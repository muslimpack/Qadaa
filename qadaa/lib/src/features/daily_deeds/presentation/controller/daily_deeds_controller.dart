// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/src/core/shared/loading.dart';
import 'package:qadaa/src/core/utils/print.dart';
import 'package:qadaa/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:qadaa/src/features/daily_deeds/data/data_source/sf_data_source.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds_extension.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/slot.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/daily_deeds_editor.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DailyDeedsController extends GetxController {
  bool isLoading = true;
  final Map<DateTime, bool> dataCollection = {};
  late final List<Slot> slots = [];
  late final CalendarController controller;
  late CalendarDataSource dataSource;

  @override
  void onInit() {
    controller = CalendarController();
    loadData();

    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  Map<DateTime, List<Appointment>> getAppointments() {
    return {};
  }

  Future loadData() async {
    await dailyDeedsRepo.addMissingDays();
    final loadedDeeds = await dailyDeedsRepo.getDailyDeedsByDateRange(
      DateTime.now().subtract(
        const Duration(
          days: 30,
        ),
      ),
      DateTime.now().add(
        const Duration(
          days: 30,
        ),
      ),
    );

    final map = {for (final e in loadedDeeds) e.date: true};
    dataCollection.addAll(map);

    slots.addAll(loadedDeeds.convertToSlot());

    dataSource = SlotsDataSourceLoadMore(slots, dataCollection);

    isLoading = false;
    update();
  }

  /// Methods

  Future<void> onTap(CalendarTapDetails calendarTapDetails) async {
    final List<CalendarElement> allowToTouch = [
      CalendarElement.appointment,
      CalendarElement.calendarCell,
    ];

    if (!allowToTouch.contains(calendarTapDetails.targetElement)) {
      return;
    }

    return _edit(calendarTapDetails);
  }

  Future<void> onLongPress(
    CalendarLongPressDetails calendarLongPressDetails,
  ) async {
    final List<CalendarElement> allowToTouch = [
      // CalendarElement.appointment,
      CalendarElement.calendarCell,
    ];

    if (!allowToTouch.contains(calendarLongPressDetails.targetElement)) {
      return;
    }

    return _edit(calendarLongPressDetails);
  }

  Future<void> _edit(CalendarTouchDetails details) async {
    if (details.date == null) return;
    qadaaPrint(details.date);

    final DailyDeeds? result = await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return DailyDeedsEditor.byDateTime(
          dateTime: details.date!,
        );
      },
    );

    if (result != null) {
      qadaaPrint('Edited Prayers: $result');
      await dailyDeedsRepo.insertDailyDeeds(result);
      update();
    }
  }

  /// Builders

  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
    if (details.appointments.length < 5 &&
        details.date.isBefore(DateTime.now())) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(.2),
            width: .5,
          ),
        ),
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow.withOpacity(.1),
          ),
          child: Text(
            details.date.day.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    final List<Widget> slots =
        details.appointments.fold([], (previousValue, e) {
      if (e is! Slot) return previousValue;
      final meeting = e;

      if (meeting.order % 5 != 0) return previousValue;

      final slot = Expanded(
        child: Container(
          color: meeting.background,
          padding: const EdgeInsets.all(2.0),
          child: FittedBox(
            child: Text(
              meeting.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      return previousValue..add(slot);
    });

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.withOpacity(.2),
          width: .5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            details.date.day.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ...slots,
        ],
      ),
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails calendarAppointmentDetails,
  ) {
    final Slot meeting = calendarAppointmentDetails.appointments.first as Slot;

    return ColoredBox(
      color: meeting.background,
      child: Center(
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: RotatedBox(
              quarterTurns:
                  controller.view?.index == CalendarView.week.index ? 3 : 4,
              child: Text(
                meeting.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loadMoreBuilder(
    BuildContext context,
    LoadMoreCallback loadMoreAppointments,
  ) {
    return FutureBuilder<void>(
      future: loadMoreAppointments(),
      builder: (context, snapShot) {
        return const Loading();
      },
    );
  }
}
