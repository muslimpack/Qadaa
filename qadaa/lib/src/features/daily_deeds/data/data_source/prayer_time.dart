class PrayerTime {
  static PrayerTime instance = PrayerTime();

  DateTime get fajr => DateTime(0, 0, 0, 5);

  DateTime get shuruq => DateTime(0, 0, 0, 6, 30);

  DateTime get doha => shuruq.add(const Duration(minutes: 20));

  DateTime get dhuhr => DateTime(0, 0, 0, 12);

  DateTime get asr => DateTime(0, 0, 0, 15);

  DateTime get maghrib => DateTime(0, 0, 0, 17);

  DateTime get isha => DateTime(0, 0, 0, 19);
  DateTime get midnight => DateTime(0, 0, 0, 23, 59, 59);

  Duration get fajrDuration => shuruq.difference(fajr);
  Duration get dohaDuration =>
      dhuhr.subtract(const Duration(minutes: 20)).difference(doha);
  Duration get dhuhrDuration => asr.difference(dhuhr);
  Duration get asrDuration =>
      maghrib.subtract(const Duration(minutes: 20)).difference(asr);
  Duration get maghribDuration => isha.difference(maghrib);
  Duration get ishaDuration => midnight.difference(isha);
}
