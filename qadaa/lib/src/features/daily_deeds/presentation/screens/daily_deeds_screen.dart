// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/utils/print.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/meeting.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/daily_deeds_editor.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DailyDeedsScreen extends StatelessWidget {
  const DailyDeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        showNavigationArrow: true,
        showTodayButton: true,
        showWeekNumber: true,
        showDatePickerButton: true,
        // allowViewNavigation: true,
        firstDayOfWeek: DateTime.saturday,
        view: CalendarView.month,
        dataSource: DailyDeedsDataSource(_getDataSource()),
        initialSelectedDate: DateTime.now(),
        maxDate: DateTime.now(),
        allowedViews: const <CalendarView>[
          CalendarView.day,
          CalendarView.workWeek,
          CalendarView.week,
          CalendarView.month,
          CalendarView.schedule,
        ],
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.none,
        ),
        appointmentBuilder: (context, calendarAppointmentDetails) {
          final Meeting meeting =
              calendarAppointmentDetails.appointments.first as Meeting;
          return Card(
            color: meeting.background,
            child: Center(
              child: Text(
                meeting.eventName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
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

          return Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: details.appointments.map(
                (e) {
                  final meeting = e as Meeting;
                  return Expanded(
                    child: ColoredBox(
                      color: meeting.background,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: FittedBox(
                          child: Text(
                            meeting.eventName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          );
        },
        onTap: (calendarTapDetails) async {
          final result = await showDialog(
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
            // Handle the edited instance
            qadaaPrint('Edited Prayers: $result');
          }
        },
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now().subtract(const Duration(days: 2));

    meetings.add(
      Meeting(
        S.current.fajr,
        today.copyWith(hour: 5),
        today.copyWith(hour: 6),
        Colors.greenAccent,
        false,
      ),
    );
    meetings.add(
      Meeting(
        S.current.dhuhr,
        today.copyWith(hour: 12),
        today.copyWith(hour: 15),
        Colors.pink,
        false,
      ),
    );
    meetings.add(
      Meeting(
        S.current.asr,
        today.copyWith(hour: 15),
        today.copyWith(hour: 17),
        Colors.greenAccent,
        false,
      ),
    );
    meetings.add(
      Meeting(
        S.current.maghrib,
        today.copyWith(hour: 17),
        today.copyWith(hour: 19),
        Colors.pink,
        false,
      ),
    );
    meetings.add(
      Meeting(
        S.current.ishaa,
        today.copyWith(hour: 19),
        today.copyWith(hour: 23, minute: 59, second: 59),
        Colors.greenAccent,
        false,
      ),
    );
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class DailyDeedsDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  DailyDeedsDataSource(List<Meeting> source) {
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
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  @override
  String? getNotes(int index) {
    return "";
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
