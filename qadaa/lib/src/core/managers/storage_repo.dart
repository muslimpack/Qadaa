import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/enum/enum.dart';
import 'package:qadaa/src/core/enum/splash_background.dart';

final StorageRepo storageRepo = StorageRepo();

class StorageRepo {
  static late Box prayerBox;

  static void initialStorage() {
    prayerBox = Hive.box(kAppStorageBoxName);
  }

  /// ******************************
  /// Keys
  /// ******************************

  // Prayer
  static const String fajrKey = "Fajr";
  static const String dhuhrKey = "Dhuhr";
  static const String asrKey = "Asr";
  static const String maghribKey = "Maghrib";
  static const String ishaKey = "Isha";

  /// Prayers Max
  static const String maxFajrKey = "MaxFajr";
  static const String maxDhuhrKey = "MaxDhuhr";
  static const String maxAsrKey = "MaxAsr";
  static const String maxMaghribKey = "MaxMaghrib";
  static const String maxIshaKey = "MaxIsha";

  // Fasting
  static const String fastingKey = "Fasting";
  static const String maxFastingKey = "MaxFasting";

  /// ******************************
  /// Add Zone
  /// ******************************
  void addFasting({
    required int days,
  }) {
    _addSingle(valToAdd: days, key: fastingKey, maxKey: maxFastingKey);
  }

  void addPrayer({
    int fajr = 0,
    int dhuhr = 0,
    int asr = 0,
    int maghrib = 0,
    int isha = 0,
  }) {
    _addSingle(valToAdd: fajr, key: fajrKey, maxKey: maxFajrKey);
    _addSingle(valToAdd: dhuhr, key: dhuhrKey, maxKey: maxDhuhrKey);
    _addSingle(valToAdd: asr, key: asrKey, maxKey: maxAsrKey);
    _addSingle(valToAdd: maghrib, key: maghribKey, maxKey: maxMaghribKey);
    _addSingle(valToAdd: isha, key: ishaKey, maxKey: maxIshaKey);
  }

  void _addSingle({
    required int valToAdd,
    required String key,
    required String maxKey,
  }) {
    final int newVal = _getNumber(key) + valToAdd;

    if (newVal > _getMax(maxKey)) {
      prayerBox.put(maxKey, newVal);
    }

    if (newVal == 0) {
      prayerBox.put(maxKey, 1);
    }

    prayerBox.put(key, newVal < 0 ? 0 : newVal);
  }

  void addDay({required int? value}) {
    if (value == null) return;
    addPrayer(
      fajr: value,
      dhuhr: value,
      asr: value,
      maghrib: value,
      isha: value,
    );
  }

  void addWeek({required int? value}) {
    if (value == null) return;
    addDay(value: value * 7);
  }

  void addMonth({required int? value}) {
    if (value == null) return;
    addDay(value: value * 30);
  }

  void addYear({required int? value}) {
    if (value == null) return;
    addDay(value: value * 365);
  }

  int getDays() {
    final List<int> prayerTimesForEach = [
      getFajr(),
      getDhuhr(),
      getAsr(),
      getMaghrib(),
      getIsha(),
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
      getMaxIsha(),
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

  int _getNumber(String pray) {
    final int pray0 = prayerBox.get(pray, defaultValue: 0) as int;
    return (pray0.isNaN || pray0.isInfinite) ? 0 : pray0;
  }

  int getFajr() => _getNumber(fajrKey);

  int getDhuhr() => _getNumber(dhuhrKey);

  int getAsr() => _getNumber(asrKey);

  int getMaghrib() => _getNumber(maghribKey);

  int getIsha() => _getNumber(ishaKey);

  int getFasting() => _getNumber(fastingKey);

  /// ******************************
  /// Get Max Zone
  /// ******************************

  int _getMax(String pray) {
    final int pray0 = prayerBox.get(pray, defaultValue: 1) as int;
    return (pray0.isNaN || pray0.isInfinite || pray0 < 1) ? 1 : pray0;
  }

  int getMaxFajr() => _getMax(maxFajrKey);

  int getMaxDhuhr() => _getMax(maxDhuhrKey);

  int getMaxAsr() => _getMax(maxAsrKey);

  int getMaxMaghrib() => _getMax(maxMaghribKey);

  int getMaxIsha() => _getMax(maxIshaKey);

  int getMaxFasting() => _getMax(maxFastingKey);

  /// ******************************
  /// Settings
  /// ******************************

  int getAllRemainingPrayer() {
    return getFajr() + getDhuhr() + getAsr() + getMaghrib() + getIsha();
  }

  void reset() {
    // Prayer
    prayerBox.put(fajrKey, 0);
    prayerBox.put(dhuhrKey, 0);
    prayerBox.put(asrKey, 0);
    prayerBox.put(maghribKey, 0);
    prayerBox.put(ishaKey, 0);
    prayerBox.put(maxFajrKey, 1);
    prayerBox.put(maxDhuhrKey, 1);
    prayerBox.put(maxAsrKey, 1);
    prayerBox.put(maxMaghribKey, 1);
    prayerBox.put(maxIshaKey, 1);
    // Fasting
    prayerBox.put(fastingKey, 0);
    prayerBox.put(maxFastingKey, 1);
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

  /// ******************************
  /// Settings
  /// ******************************

  void toggleSplashBackground() {
    prayerBox.put(
      "SplashBackground",
      enumToMap(getSplashBackground().toggle()),
    );
  }

  SplashBackGroundEnum getSplashBackground() {
    final str = prayerBox
        .get(
          "SplashBackground",
          defaultValue: enumToMap(SplashBackGroundEnum.staticImage),
        )
        .toString();

    return enumFromMap(
      str,
      SplashBackGroundEnum.values,
      SplashBackGroundEnum.staticImage,
    );
  }

  int getSplashBackgroundIndex() {
    final int index =
        prayerBox.get("SplashBackgroundIndex", defaultValue: 0) as int;
    return (index.isNaN || index.isInfinite) ? 0 : index;
  }

  void setSplashBackgroundIndex(int index) {
    prayerBox.put("SplashBackgroundIndex", index);
  }

  bool get isLockEnabled =>
      prayerBox.get("is_app_locked", defaultValue: false) as bool;

  String get passCode =>
      prayerBox.get("passcode", defaultValue: "0000") as String;

  void setIsLockEnabled(bool value) {
    prayerBox.put("is_app_locked", value);
  }

  void setPassCode(String passCode) {
    prayerBox.put("passcode", passCode);
  }

  static const String _localeKey = "locale";
  Locale? get locale {
    final value = prayerBox.get(_localeKey) as String?;
    if (value == null) return null;
    return Locale(value);
  }

  Future localeChange(Locale locale) async {
    return prayerBox.put(_localeKey, locale.languageCode);
  }
}
