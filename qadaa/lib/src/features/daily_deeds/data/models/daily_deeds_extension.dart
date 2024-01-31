import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/extensions/date_time.dart';
import 'package:qadaa/src/features/daily_deeds/data/data_source/prayer_time.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/slot.dart';

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
        from: setDateTimeTime(today, prayerTime.fajr),
        to: setDateTimeTime(
          today,
          prayerTime.fajr.add(prayerTime.fajrDuration),
        ),
        background: getColor(obligatoryPrayers.fajr),
      ),
    );

    slots.add(
      Slot(
        order: 10,
        title: S.current.dhuhr,
        from: setDateTimeTime(today, prayerTime.dhuhr),
        to: setDateTimeTime(
          today,
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColor(obligatoryPrayers.dhuhr),
      ),
    );
    slots.add(
      Slot(
        order: 15,
        title: S.current.asr,
        from: setDateTimeTime(today, prayerTime.asr),
        to: setDateTimeTime(
          today,
          prayerTime.asr.add(prayerTime.asrDuration),
        ),
        background: getColor(obligatoryPrayers.asr),
      ),
    );
    slots.add(
      Slot(
        order: 20,
        title: S.current.maghrib,
        from: setDateTimeTime(today, prayerTime.maghrib),
        to: setDateTimeTime(
          today,
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColor(obligatoryPrayers.maghrib),
      ),
    );
    slots.add(
      Slot(
        order: 25,
        title: S.current.ishaa,
        from: setDateTimeTime(today, prayerTime.isha),
        to: setDateTimeTime(
          today,
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
        from: setDateTimeTime(today, prayerTime.fajr),
        to: setDateTimeTime(
          today,
          prayerTime.fajr.add(prayerTime.fajrDuration),
        ),
        background: getColorByInt(additionalPrayers.fajrPre),
      ),
    );

    slots.add(
      Slot(
        order: 6,
        title: "الضحى",
        from: setDateTimeTime(today, prayerTime.doha),
        to: setDateTimeTime(
          today,
          prayerTime.doha.add(prayerTime.dohaDuration),
        ),
        background: getColorByInt(additionalPrayers.doha),
      ),
    );

    slots.add(
      Slot(
        order: 9,
        title: "الظهر قبليه",
        from: setDateTimeTime(today, prayerTime.dhuhr),
        to: setDateTimeTime(
          today,
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColorByInt(additionalPrayers.dhuhrPre),
      ),
    );

    slots.add(
      Slot(
        order: 11,
        title: "الظهر بعديه",
        from: setDateTimeTime(today, prayerTime.dhuhr),
        to: setDateTimeTime(
          today,
          prayerTime.dhuhr.add(prayerTime.dhuhrDuration),
        ),
        background: getColorByInt(additionalPrayers.dhuhrAfter),
      ),
    );

    slots.add(
      Slot(
        order: 14,
        title: "العصر قبليه",
        from: setDateTimeTime(today, prayerTime.asr),
        to: setDateTimeTime(
          today,
          prayerTime.asr.add(prayerTime.asrDuration),
        ),
        background: getColorByInt(additionalPrayers.asrPre),
      ),
    );

    slots.add(
      Slot(
        order: 19,
        title: "المغرب قبليه",
        from: setDateTimeTime(today, prayerTime.maghrib),
        to: setDateTimeTime(
          today,
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColorByInt(additionalPrayers.maghribPre),
      ),
    );

    slots.add(
      Slot(
        order: 21,
        title: "المغرب بعديه",
        from: setDateTimeTime(today, prayerTime.maghrib),
        to: setDateTimeTime(
          today,
          prayerTime.maghrib.add(prayerTime.maghribDuration),
        ),
        background: getColorByInt(additionalPrayers.maghribAfter),
      ),
    );

    slots.add(
      Slot(
        order: 24,
        title: "العشاء قبليه",
        from: setDateTimeTime(today, prayerTime.isha),
        to: setDateTimeTime(
          today,
          prayerTime.isha.add(prayerTime.ishaDuration),
        ),
        background: getColorByInt(additionalPrayers.ishaaPre),
      ),
    );

    slots.add(
      Slot(
        order: 26,
        title: "العشاء بعديه",
        from: setDateTimeTime(today, prayerTime.isha),
        to: setDateTimeTime(
          today,
          prayerTime.isha.add(prayerTime.ishaDuration),
        ),
        background: getColorByInt(additionalPrayers.ishaaAfter),
      ),
    );

    slots.add(
      Slot(
        order: 27,
        title: "قيام الليل",
        from: setDateTimeTime(today, prayerTime.midnight),
        to: setDateTimeTime(
          today.add(const Duration(days: 1)),
          prayerTime.fajr,
        ),
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

DateTime setDateTimeTime(DateTime dateTime, DateTime time) {
  return dateTime.setTime(time);
}
