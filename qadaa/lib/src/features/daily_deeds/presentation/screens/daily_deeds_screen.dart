import 'package:flutter/material.dart';
import 'package:qadaa/src/core/extensions/date_time.dart';
import 'package:qadaa/src/core/utils/print.dart';
import 'package:qadaa/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds_extension.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/slot.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/daily_deeds_editor.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DailyDeedsScreen extends StatefulWidget {
  const DailyDeedsScreen({super.key});

  @override
  State<DailyDeedsScreen> createState() => _DailyDeedsScreenState();
}

class _DailyDeedsScreenState extends State<DailyDeedsScreen> {
  late final CalendarController _controller;
  @override
  void initState() {
    _controller = CalendarController();

    dailyDeedsRepo.getAllDailyDeeds();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        controller: _controller,
        initialDisplayDate: DateTime.now(),
        initialSelectedDate: DateTime.now(),
        maxDate: DateTime.now().add(const Duration(days: 1)),
        minDate: DateTime(1900),

        showNavigationArrow: true,
        showTodayButton: true,
        // showWeekNumber: true,
        allowViewNavigation: true,
        showDatePickerButton: true,
        firstDayOfWeek: DateTime.saturday,
        view: CalendarView.month,

        allowedViews: const <CalendarView>[
          CalendarView.day,
          CalendarView.week,
          CalendarView.month,
        ],

        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.none,
          // appointmentDisplayCount: 5,
          // showAgenda: true,
          showTrailingAndLeadingDates: false,
        ),

        dataSource: DailyDeedsDataSourceLoadMore([]),
        appointmentBuilder: _appointmentBuilder,
        monthCellBuilder: _monthCellBuilder,
        loadMoreWidgetBuilder: _loadMoreBuilder,

        onTap: _onTap,
        onLongPress: _onLongPress,
      ),
    );
  }

  Future<void> _onTap(CalendarTapDetails calendarTapDetails) async {
    final List<CalendarElement> allowToTouch = [
      CalendarElement.appointment,
      // CalendarElement.calendarCell,
    ];

    if (!allowToTouch.contains(calendarTapDetails.targetElement)) {
      return;
    }

    return _edit(calendarTapDetails);
  }

  Future<void> _onLongPress(
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

  Future<void> _edit(CalendarTouchDetails calendarTapDetails) async {
    if (calendarTapDetails.date == null) return;
    final DailyDeeds? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DailyDeedsEditor(
          dailyDeeds: DailyDeeds.empty(
            date: calendarTapDetails.date!.dateOnly,
          ),
        );
      },
    );

    if (result != null) {
      qadaaPrint('Edited Prayers: $result');
      await dailyDeedsRepo.insertDailyDeeds(result);
      setState(() {});
    }
  }

  Widget _monthCellBuilder(BuildContext context, MonthCellDetails details) {
    if (details.appointments.isEmpty && details.date.isBefore(DateTime.now())) {
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

  Widget _appointmentBuilder(
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
                  _controller.view?.index == CalendarView.week.index ? 3 : 4,
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

  Widget _loadMoreBuilder(
    BuildContext context,
    LoadMoreCallback loadMoreAppointments,
  ) {
    return FutureBuilder<void>(
      future: loadMoreAppointments(),
      builder: (context, snapShot) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class DailyDeedsDataSource extends CalendarDataSource {
  DailyDeedsDataSource(List<Slot> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).title;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Slot _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Slot meetingData;
    if (meeting is Slot) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class DailyDeedsDataSourceLoadMore extends DailyDeedsDataSource {
  DailyDeedsDataSourceLoadMore(super.source);

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    qadaaPrint("$startDate || $endDate");
    final loadedDeeds = await dailyDeedsRepo.getDailyDeedsByDateRange(
      startDate.subtract(const Duration(days: 2)),
      endDate.add(const Duration(days: 2)),
    );

    final List<Slot> slots = loadedDeeds
        .map(
      (e) => e.allSlots(),
    )
        .fold(
      <Slot>[],
      (previousValue, element) => previousValue..addAll(element),
    );

    qadaaPrint(slots.length);

    appointments = slots.toSet().toList();
    notifyListeners(CalendarDataSourceAction.add, slots);
  }
}
