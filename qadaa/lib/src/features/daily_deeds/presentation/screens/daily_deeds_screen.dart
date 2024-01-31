import 'package:flutter/material.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        controller: _controller,
        initialSelectedDate: DateTime.now(),
        maxDate: DateTime.now().add(const Duration(days: 1)),
        minDate: DateTime(1900),

        showNavigationArrow: true,
        showTodayButton: true,
        // showWeekNumber: true,
        // allowViewNavigation: true,

        showDatePickerButton: true,
        firstDayOfWeek: DateTime.saturday,
        view: CalendarView.month,
        dataSource: DailyDeedsDataSourceLoadMore([
          ...DailyDeeds.empty(
            date: DateTime.now().subtract(const Duration(days: 5)),
          ).allSlots(),
          ...DailyDeeds.empty(
            date: DateTime.now().subtract(const Duration(days: 4)),
          ).allSlots(),
          ...DailyDeeds.empty(
            date: DateTime.now().subtract(const Duration(days: 3)),
          ).allSlots(),
          ...DailyDeeds.empty(
            date: DateTime.now().subtract(const Duration(days: 2)),
          ).allSlots(),
          ...DailyDeeds.empty(
            date: DateTime.now().subtract(const Duration(days: 1)),
          ).allSlots(),
          ...DailyDeeds.empty(date: DateTime.now()).allSlots(),
        ]),

        allowedViews: const <CalendarView>[
          CalendarView.day,
          CalendarView.week,
          CalendarView.month,
          CalendarView.schedule,
        ],

        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.none,
          // appointmentDisplayCount: 5,
          // showAgenda: true,
          showTrailingAndLeadingDates: false,
        ),

        appointmentBuilder: (context, calendarAppointmentDetails) {
          final Slot meeting =
              calendarAppointmentDetails.appointments.first as Slot;

          return ColoredBox(
            color: meeting.background,
            child: Center(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RotatedBox(
                    quarterTurns:
                        _controller.view?.index == CalendarView.week.index
                            ? 3
                            : 4,
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
        },
        monthCellBuilder: (context, details) {
          if (details.appointments.isEmpty &&
              details.date.isBefore(DateTime.now())) {
            return Container(
              margin: const EdgeInsets.all(5),
              color: Colors.yellow.withOpacity(.1),
            );
          }

          final List<Widget> slots =
              details.appointments.fold([], (previousValue, e) {
            final meeting = e as Slot;

            if (meeting.order % 5 != 0) return previousValue;

            final slot = Expanded(
              child: ColoredBox(
                color: meeting.background,
                child: Padding(
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
              ),
            );

            return previousValue..add(slot);
          });

          return Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: slots,
            ),
          );
        },

        onLongPress: (calendarTapDetails) async {
          final DailyDeeds? result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return DailyDeedsEditor(
                dailyDeeds: DailyDeeds.empty(
                  date: calendarTapDetails.date ?? DateTime.now(),
                ),
              );
            },
          );

          if (result != null) {
            qadaaPrint('Edited Prayers: $result');

            await dailyDeedsRepo.insertDailyDeeds(result);
          }
        },
      ),
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
    qadaaPrint("DailyDeedsDataSourceLoadMore");

    final loadedDeeds =
        await dailyDeedsRepo.getDailyDeedsByDateRange(startDate, endDate);

    qadaaPrint("DailyDeedsDataSourceLoadMore ${loadedDeeds.length}");

    final List<Slot> slots = loadedDeeds
        .map(
      (e) => e.allSlots(),
    )
        .fold(
      <Slot>[],
      (previousValue, element) => previousValue..addAll(element),
    );

    appointments!.addAll(slots);
    appointments = slots;
    notifyListeners(CalendarDataSourceAction.add, slots);
  }
}
