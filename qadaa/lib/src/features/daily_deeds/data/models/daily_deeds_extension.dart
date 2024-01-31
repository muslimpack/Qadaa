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
        order: 4,
        title: "ركعتا الفجر",
        from: today.setTime(prayerTime.fajr),
        to: today.setTime(
          prayerTime.fajr.add(prayerTime.fajrDuration),
        ),
        background: getColorByInt(additionalPrayers.fajrPre),
      ),
    );

    slots.add(
      Slot(
        order: 6,
        title: "الضحى",
        from: today.setTime(prayerTime.doha),
        to: today.setTime(
          prayerTime.doha.add(prayerTime.dohaDuration),
        ),
        background: getColorByInt(additionalPrayers.doha),
      ),
    );

    slots.add(
      Slot(
        order: 9,
        title: "الظهر قبليه",
        from: today.setTime(prayerTime.dhuhr),
        to: today.setTime(
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColorByInt(additionalPrayers.dhuhrPre),
      ),
    );

    slots.add(
      Slot(
        order: 11,
        title: "الظهر بعديه",
        from: today.setTime(prayerTime.dhuhr),
        to: today.setTime(
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColorByInt(additionalPrayers.dhuhrAfter),
      ),
    );

    slots.add(
      Slot(
        order: 14,
        title: "العصر قبليه",
        from: today.setTime(prayerTime.asr),
        to: today.setTime(
          prayerTime.asr.add(prayerTime.asrDuration),
        ),
        background: getColorByInt(additionalPrayers.asrPre),
      ),
    );

    slots.add(
      Slot(
        order: 19,
        title: "المغرب قبليه",
        from: today.setTime(prayerTime.maghrib),
        to: today.setTime(
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColorByInt(additionalPrayers.maghribPre),
      ),
    );

    slots.add(
      Slot(
        order: 21,
        title: "المغرب بعديه",
        from: today.setTime(prayerTime.maghrib),
        to: today.setTime(
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColorByInt(additionalPrayers.maghribAfter),
      ),
    );

    slots.add(
      Slot(
        order: 24,
        title: "العشاء قبليه",
        from: today.setTime(prayerTime.isha),
        to: today.setTime(prayerTime.isha.add(prayerTime.ishaDuration)),
        background: getColorByInt(additionalPrayers.ishaaPre),
      ),
    );

    slots.add(
      Slot(
        order: 26,
        title: "العشاء بعديه",
        from: today.setTime(prayerTime.isha),
        to: today.setTime(prayerTime.isha.add(prayerTime.ishaDuration)),
        background: getColorByInt(additionalPrayers.ishaaAfter),
      ),
    );

    slots.add(
      Slot(
        order: 27,
        title: "قيام الليل",
        from: today.setTime(prayerTime.midnight),
        to: today.add(const Duration(days: 1)).setTime(prayerTime.fajr),
        background: getColorByInt(additionalPrayers.ishaaAfter),
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
