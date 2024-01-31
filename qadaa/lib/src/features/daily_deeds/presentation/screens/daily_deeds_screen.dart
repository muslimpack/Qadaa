// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/src/core/shared/loading.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/controller/daily_deeds_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DailyDeedsScreen extends StatefulWidget {
  const DailyDeedsScreen({super.key});

  @override
  State<DailyDeedsScreen> createState() => _DailyDeedsScreenState();
}

class _DailyDeedsScreenState extends State<DailyDeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DailyDeedsController(),
      builder: (controller) {
        final now = DateTime.now();
        return controller.isLoading
            ? const Loading()
            : Scaffold(
                body: SfCalendar(
                  key: controller.sfCalendarKey,
                  controller: controller.controller,
                  initialDisplayDate: now,
                  initialSelectedDate: now,
                  maxDate: now.add(const Duration(days: 1)),
                  minDate: DateTime(1900),

                  showNavigationArrow: true,
                  showTodayButton: true,
                  // showWeekNumber: true,
                  // allowViewNavigation: true,
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

                  dataSource: controller.dataSource,
                  appointmentBuilder: controller.appointmentBuilder,
                  monthCellBuilder: controller.monthCellBuilder,
                  loadMoreWidgetBuilder: controller.loadMoreBuilder,

                  onTap: controller.onTap,
                  onLongPress: controller.onLongPress,
                ),
              );
      },
    );
  }
}
