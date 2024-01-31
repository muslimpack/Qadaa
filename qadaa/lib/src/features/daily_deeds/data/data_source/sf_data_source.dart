// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:qadaa/src/features/daily_deeds/data/data_source/daily_deeds_repo.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds_extension.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/slot.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SlotsDataSource extends CalendarDataSource {
  SlotsDataSource(List<Slot> source) {
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

class SlotsDataSourceLoadMore extends SlotsDataSource {
  final Map<DateTime, bool> dataCollection;
  SlotsDataSourceLoadMore(
    super.source,
    this.dataCollection,
  );

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    /// Get Deeds for that dateTime range
    final loadedDeeds = await dailyDeedsRepo.getDailyDeedsByDateRange(
      startDate.subtract(const Duration(days: 2)),
      endDate.add(const Duration(days: 2)),
    );

    /// Get unique deeds
    final deedsToAdd = loadedDeeds.fold(
      <DailyDeeds>[],
      (previousValue, element) {
        if (!dataCollection.containsKey(element.date)) {
          return (previousValue..add(element));
        } else {
          return previousValue;
        }
      },
    );

    /// Add deeds to collection
    final map = {for (final e in loadedDeeds) e.date: true};
    dataCollection.addAll(map);

    /// Create Slots of Deeds
    final List<Slot> slots = deedsToAdd.convertToSlot();

    /// Add to sfCalender
    appointments!.addAll(slots);
    notifyListeners(
      CalendarDataSourceAction.add,
      slots,
    );
  }
}
