import 'package:hive/hive.dart';

final StorageRepo storageRepo = StorageRepo();

class StorageRepo {
  static late Box prayerBox;

  static initialStorage() {
    prayerBox = Hive.box("Prayers");
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

  addPrayer(
      {int fajr = 0,
      int dhuhr = 0,
      int asr = 0,
      int maghrib = 0,
      int isha = 0}) {
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

  int getFajr() {
    int fajr = prayerBox.get("Fajr", defaultValue: 0);
    return fajr.isNaN ? 0 : fajr;
  }

  int getDhuhr() {
    int dhuhr = prayerBox.get("Dhuhr", defaultValue: 0);
    return dhuhr.isNaN ? 0 : dhuhr;
  }

  int getAsr() {
    int asr = prayerBox.get("Asr", defaultValue: 0);
    return asr.isNaN ? 0 : asr;
  }

  int getMaghrib() {
    int maghrib = prayerBox.get("Maghrib", defaultValue: 0);
    return maghrib.isNaN ? 0 : maghrib;
  }

  int getIsha() {
    int isha = prayerBox.get("Isha", defaultValue: 0);
    return isha.isNaN ? 0 : isha;
  }

  int getMaxFajr() {
    int fajr = prayerBox.get("MaxFajr", defaultValue: 1);
    return fajr;
  }

  int getMaxDhuhr() {
    int dhuhr = prayerBox.get("MaxDhuhr", defaultValue: 1);
    return dhuhr;
  }

  int getMaxAsr() {
    int asr = prayerBox.get("MaxAsr", defaultValue: 1);
    return asr;
  }

  int getMaxMaghrib() {
    int maghrib = prayerBox.get("MaxMaghrib", defaultValue: 1);
    return maghrib;
  }

  int getMaxIsha() {
    int isha = prayerBox.get("MaxIsha", defaultValue: 1);
    return isha;
  }

  int getAllRemainingPrayer() {
    return getFajr() + getDhuhr() + getAsr() + getMaghrib() + getIsha();
  }

  // qadaa every day
  String getqadaaEveryDay() {
    String? data =
        Hive.box("Prayers").get("qadaaEveryDay", defaultValue: "1").toString();

    return data == "0" ? "1" : data;
  }

  setqadaaEveryDay(String? count) {
    Hive.box("Prayers").put("qadaaEveryDay", count ?? 1);
  }

  resetqadaaEveryDay() {
    Hive.box("Prayers").put("qadaaEveryDay", 1);
  }
}
