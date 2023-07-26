import 'package:hive/hive.dart';

final StorageRepo storageRepo = StorageRepo();

class StorageRepo {
  static late Box prayerBox;

  static initialStorage() {
    prayerBox = Hive.box("Prayers");
  }

  /// ******************************
  /// Add Zone
  /// ******************************

  addPrayer({
    int fajr = 0,
    int dhuhr = 0,
    int asr = 0,
    int maghrib = 0,
    int isha = 0,
  }) {
    int newRecordFajr = prayerBox.get("Fajr", defaultValue: 0) + fajr;
    int newRecordDhuhr = prayerBox.get("Dhuhr", defaultValue: 0) + dhuhr;
    int newRecordAsr = prayerBox.get("Asr", defaultValue: 0) + asr;
    int newRecordMaghrib = prayerBox.get("Maghrib", defaultValue: 0) + maghrib;
    int newRecordIsha = prayerBox.get("Isha", defaultValue: 0) + isha;

    // Catch new max
    if (newRecordFajr > getMaxFajr()) {
      prayerBox.put("MaxFajr", newRecordFajr);
    }
    if (newRecordDhuhr > getMaxDhuhr()) {
      prayerBox.put("MaxDhuhr", newRecordDhuhr);
    }
    if (newRecordAsr > getMaxAsr()) {
      prayerBox.put("MaxAsr", newRecordAsr);
    }
    if (newRecordMaghrib > getMaxMaghrib()) {
      prayerBox.put("MaxMaghrib", newRecordMaghrib);
    }
    if (newRecordIsha > getMaxIsha()) {
      prayerBox.put("MaxIsha", newRecordIsha);
    }

    // Reset max if its praye = 0
    if (newRecordFajr == 0) {
      prayerBox.put("MaxFajr", 1);
    }
    if (newRecordDhuhr == 0) {
      prayerBox.put("MaxDhuhr", 1);
    }
    if (newRecordAsr == 0) {
      prayerBox.put("MaxAsr", 1);
    }
    if (newRecordMaghrib == 0) {
      prayerBox.put("MaxMaghrib", 1);
    }
    if (newRecordIsha == 0) {
      prayerBox.put("MaxIsha", 1);
    }
    //
    prayerBox.put("Fajr", newRecordFajr < 0 ? 0 : newRecordFajr);
    prayerBox.put("Dhuhr", newRecordDhuhr < 0 ? 0 : newRecordDhuhr);
    prayerBox.put("Asr", newRecordAsr < 0 ? 0 : newRecordAsr);
    prayerBox.put("Maghrib", newRecordMaghrib < 0 ? 0 : newRecordMaghrib);
    prayerBox.put("Isha", newRecordIsha < 0 ? 0 : newRecordIsha);
  }

  addDay({required int? value}) {
    if (value != null) {
      addPrayer(
        fajr: value,
        dhuhr: value,
        asr: value,
        maghrib: value,
        isha: value,
      );
    }
  }

  addWeek({required int? value}) {
    if (value != null) {
      addDay(value: value * 7);
    }
  }

  addMonth({required int? value}) {
    if (value != null) {
      addDay(value: value * 30);
    }
  }

  addYear({required int? value}) {
    if (value != null) {
      addDay(value: value * 365);
    }
  }

  int getDays() {
    List<int> prayerTimesForEach = [
      getFajr().toInt(),
      getDhuhr().toInt(),
      getAsr().toInt(),
      getMaghrib().toInt(),
      getIsha().toInt()
    ];
    prayerTimesForEach.sort();

    return prayerTimesForEach.first;
  }

  int getDaysMax() {
    List<int> prayerTimesForEach = [
      getMaxFajr(),
      getMaxDhuhr(),
      getMaxAsr(),
      getMaxMaghrib(),
      getMaxIsha()
    ];
    prayerTimesForEach.sort();
    if (prayerTimesForEach.last == 0) {
      return 1;
    } else {
      return prayerTimesForEach.last;
    }
  }

  /// ******************************
  /// Get Current Zone
  /// ******************************

  int _getPray(String pray) {
    int pray0 = prayerBox.get(pray, defaultValue: 0);
    return pray0.isNaN ? 0 : pray0;
  }

  int getFajr() => _getPray("Fajr");

  int getDhuhr() => _getPray("Dhuhr");

  int getAsr() => _getPray("Asr");

  int getMaghrib() => _getPray("Maghrib");

  int getIsha() => _getPray("Isha");

  /// ******************************
  /// Get Max Zone
  /// ******************************

  int getMaxPray(String pray) {
    int pray0 = prayerBox.get(pray, defaultValue: 1);
    return pray0;
  }

  int getMaxFajr() => getMaxPray("MaxFajr");

  int getMaxDhuhr() => getMaxPray("MaxDhuhr");

  int getMaxAsr() => getMaxPray("MaxAsr");

  int getMaxMaghrib() => getMaxPray("MaxMaghrib");

  int getMaxIsha() => getMaxPray("MaxIsha");

  /// ******************************
  /// Settings
  /// ******************************

  int getAllRemainingPrayer() {
    return getFajr() + getDhuhr() + getAsr() + getMaghrib() + getIsha();
  }

  reset() {
    prayerBox.put("Fajr", 0);
    prayerBox.put("Dhuhr", 0);
    prayerBox.put("Asr", 0);
    prayerBox.put("Maghrib", 0);
    prayerBox.put("Isha", 0);
    prayerBox.put("MaxFajr", 1);
    prayerBox.put("MaxDhuhr", 1);
    prayerBox.put("MaxAsr", 1);
    prayerBox.put("MaxMaghrib", 1);
    prayerBox.put("MaxIsha", 1);
  }

  /// ******************************
  /// Misc
  /// ******************************

  // qadaa every day
  String getQadaaEveryDay() {
    String? data =
        Hive.box("Prayers").get("qadaaEveryDay", defaultValue: "1").toString();

    return data == "0" ? "1" : data;
  }

  setQadaaEveryDay(String? count) {
    Hive.box("Prayers").put("qadaaEveryDay", count ?? 1);
  }

  resetQadaaEveryDay() {
    Hive.box("Prayers").put("qadaaEveryDay", 1);
  }
}
