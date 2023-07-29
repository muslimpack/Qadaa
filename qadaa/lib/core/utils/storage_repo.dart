import 'package:hive/hive.dart';
import 'package:qadaa/core/values/constant.dart';

final StorageRepo storageRepo = StorageRepo();

class StorageRepo {
  static late Box prayerBox;

  static void initialStorage() {
    prayerBox = Hive.box("Prayers");
  }

  /// ******************************
  /// Add Zone
  /// ******************************

  void addPrayer({
    int fajr = 0,
    int dhuhr = 0,
    int asr = 0,
    int maghrib = 0,
    int isha = 0,
  }) {
    final int newRecordFajr = getFajr() + fajr;
    final int newRecordDhuhr = getDhuhr() + dhuhr;
    final int newRecordAsr = getAsr() + asr;
    final int newRecordMaghrib = getMaghrib() + maghrib;
    final int newRecordIsha = getIsha() + isha;

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

    // Reset max if its pray = 0
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

  void addDay({required int? value}) {
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

  void addWeek({required int? value}) {
    if (value != null) {
      addDay(value: value * 7);
    }
  }

  void addMonth({required int? value}) {
    if (value != null) {
      addDay(value: value * 30);
    }
  }

  void addYear({required int? value}) {
    if (value != null) {
      addDay(value: value * 365);
    }
  }

  int getDays() {
    final List<int> prayerTimesForEach = [
      getFajr(),
      getDhuhr(),
      getAsr(),
      getMaghrib(),
      getIsha()
    ];
    prayerTimesForEach.sort();

    return prayerTimesForEach.first;
  }

  int getDaysMax() {
    final List<int> prayerTimesForEach = [
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
    final int pray0 = prayerBox.get(pray, defaultValue: 0) as int;
    return (pray0.isNaN || pray0.isInfinite) ? 0 : pray0;
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
    final int pray0 = prayerBox.get(pray, defaultValue: 1) as int;
    return (pray0.isNaN || pray0.isInfinite || pray0 < 1) ? 1 : pray0;
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

  void reset() {
    // Prayer
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
    // Fasting
    prayerBox.put("Fasting", 0);
    prayerBox.put("MaxFasting", 1);
  }

  /// ******************************
  /// Misc
  /// ******************************

  // qadaa every day
  String getQadaaEveryDay() {
    final String data =
        prayerBox.get("qadaaEveryDay", defaultValue: "1").toString();

    return data == "0" ? "1" : data;
  }

  void setQadaaEveryDay(String? count) {
    prayerBox.put("qadaaEveryDay", count ?? 1);
  }

  void resetQadaaEveryDay() {
    prayerBox.put("qadaaEveryDay", 1);
  }

  /// ******************************
  /// First Open
  /// ******************************

  bool isFirstOpen() {
    return prayerBox.get(
      "is_${AppConstant.appVersion}_first_open",
      defaultValue: true,
    ) as bool;
  }

  void setFirstOpen(bool val) {
    prayerBox.put("is_${AppConstant.appVersion}_first_open", val);
  }
}
