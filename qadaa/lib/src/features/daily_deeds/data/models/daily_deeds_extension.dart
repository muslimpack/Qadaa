import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/extensions/date_time.dart';
import 'package:qadaa/src/features/daily_deeds/data/data_source/prayer_time.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/slot.dart';

extension DailyDeedsListExtension on List<DailyDeeds> {
  List<Slot> convertToSlot() {
    return map(
      (e) => e.allSlots(),
    ).fold(
      <Slot>[],
      (previousValue, element) => previousValue..addAll(element),
    );
  }
}

extension DailyDeedsExtension on DailyDeeds {
  List<Slot> allSlots() {
    return [
      ...obligatoryPrayersSlots(),
      ...additionalPrayersSlots(),
      ...fastSlots(),
    ]..sort((a, b) => a.order.compareTo(b.order));
  }

  List<Slot> fastSlots() {
    return [
      Slot(
        id: date,
        order: 1,
        title: S.current.fast,
        from: date,
        to: date,
        isAllDay: true,
        background: getColor(fasting),
      ),
    ];
  }

  List<Slot> obligatoryPrayersSlots() {
    final PrayerTime prayerTime = PrayerTime.instance;
    final List<Slot> slots = <Slot>[];
    final DateTime today = date;

    slots.add(
      Slot(
        id: date,
        order: 5,
        title: S.current.fajr,
        from: today.setTime(prayerTime.fajr),
        to: today.setTime(
          prayerTime.fajr.add(prayerTime.fajrDuration),
        ),
        background: getColor(obligatoryPrayers.fajr),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 10,
        title: S.current.dhuhr,
        from: today.setTime(prayerTime.dhuhr),
        to: today.setTime(
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColor(obligatoryPrayers.dhuhr),
      ),
    );
    slots.add(
      Slot(
        id: date,
        order: 15,
        title: S.current.asr,
        from: today.setTime(prayerTime.asr),
        to: today.setTime(
          prayerTime.asr.add(prayerTime.asrDuration),
        ),
        background: getColor(obligatoryPrayers.asr),
      ),
    );
    slots.add(
      Slot(
        id: date,
        order: 20,
        title: S.current.maghrib,
        from: today.setTime(prayerTime.maghrib),
        to: today.setTime(
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColor(obligatoryPrayers.maghrib),
      ),
    );
    slots.add(
      Slot(
        id: date,
        order: 25,
        title: S.current.ishaa,
        from: today.setTime(prayerTime.isha),
        to: today.setTime(
          prayerTime.isha.add(prayerTime.ishaDuration),
        ),
        background: getColor(obligatoryPrayers.ishaa),
      ),
    );

    return slots;
  }

  List<Slot> additionalPrayersSlots() {
    final PrayerTime prayerTime = PrayerTime.instance;
    final List<Slot> slots = <Slot>[];
    final DateTime today = date;

    slots.add(
      Slot(
        id: date,
        order: 4,
        title: S.current.fajrPre,
        from: today.setTime(prayerTime.fajr),
        to: today.setTime(
          prayerTime.fajr.add(prayerTime.fajrDuration),
        ),
        background: getColorByInt(additionalPrayers.fajrPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 6,
        title: S.current.doha,
        from: today.setTime(prayerTime.doha),
        to: today.setTime(
          prayerTime.doha.add(prayerTime.dohaDuration),
        ),
        background: getColorByInt(additionalPrayers.doha),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 9,
        title: S.current.dhuhrPre,
        from: today.setTime(prayerTime.dhuhr),
        to: today.setTime(
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColorByInt(additionalPrayers.dhuhrPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 11,
        title: S.current.dhuhrAfter,
        from: today.setTime(prayerTime.dhuhr),
        to: today.setTime(
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColorByInt(additionalPrayers.dhuhrAfter),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 14,
        title: S.current.asrPre,
        from: today.setTime(prayerTime.asr),
        to: today.setTime(
          prayerTime.asr.add(prayerTime.asrDuration),
        ),
        background: getColorByInt(additionalPrayers.asrPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 19,
        title: S.current.maghribPre,
        from: today.setTime(prayerTime.maghrib),
        to: today.setTime(
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColorByInt(additionalPrayers.maghribPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 21,
        title: S.current.maghribAfter,
        from: today.setTime(prayerTime.maghrib),
        to: today.setTime(
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColorByInt(additionalPrayers.maghribAfter),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 24,
        title: S.current.ishaaPre,
        from: today.setTime(prayerTime.isha),
        to: today.setTime(prayerTime.isha.add(prayerTime.ishaDuration)),
        background: getColorByInt(additionalPrayers.ishaaPre),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 26,
        title: S.current.ishaaAfter,
        from: today.setTime(prayerTime.isha),
        to: today.setTime(prayerTime.isha.add(prayerTime.ishaDuration)),
        background: getColorByInt(additionalPrayers.ishaaAfter),
      ),
    );

    slots.add(
      Slot(
        id: date,
        order: 27,
        title: S.current.nightPrayer,
        from: today.setTime(prayerTime.midnight),
        to: today.add(const Duration(days: 1)).setTime(prayerTime.fajr),
        background: getColorByInt(additionalPrayers.nightPrayer),
      ),
    );

    return slots;
  }

  Color getColor(bool value) {
    return value ? Colors.greenAccent : Colors.pink;
  }

  Color getColorByInt(int value) {
    return getColor(value != 0);
  }
}
