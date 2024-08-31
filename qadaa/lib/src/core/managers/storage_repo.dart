import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/enum/enum.dart';
import 'package:qadaa/src/core/enum/splash_background.dart';
import 'package:qadaa/src/core/utils/print.dart';

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
  Future addFasting({
    required int days,
  }) async {
    await _addSingle(valToAdd: days, key: fastingKey, maxKey: maxFastingKey);
  }

  Future addPrayer({
    int fajr = 0,
    int dhuhr = 0,
    int asr = 0,
    int maghrib = 0,
    int isha = 0,
  }) async {
    await _addSingle(valToAdd: fajr, key: fajrKey, maxKey: maxFajrKey);
    await _addSingle(valToAdd: dhuhr, key: dhuhrKey, maxKey: maxDhuhrKey);
    await _addSingle(valToAdd: asr, key: asrKey, maxKey: maxAsrKey);
    await _addSingle(valToAdd: maghrib, key: maghribKey, maxKey: maxMaghribKey);
    await _addSingle(valToAdd: isha, key: ishaKey, maxKey: maxIshaKey);
  }

  Future _addSingle({
    required int valToAdd,
    required String key,
    required String maxKey,
  }) async {
    final int newVal = _getNumber(key) + valToAdd;

    if (newVal > _getMax(maxKey)) {
      await prayerBox.put(maxKey, newVal);
    }

    if (newVal == 0) {
      await prayerBox.put(maxKey, 1);
    }

    await prayerBox.put(key, newVal < 0 ? 0 : newVal);
  }

  Future addDay({required int? value}) async {
    if (value == null) return;
    await addPrayer(
      fajr: value,
      dhuhr: value,
      asr: value,
      maghrib: value,
      isha: value,
    );
  }

  Future<void> addWeek({required int? value}) async {
    if (value == null) return;
    await addDay(value: value * 7);
  }

  Future<void> addMonth({required int? value}) async {
    if (value == null) return;
    await addDay(value: value * 30);
  }

  Future<void> addYear({required int? value}) async {
    if (value == null) return;
    await addDay(value: value * 365);
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

  Future reset() async {
    // Prayer
    await prayerBox.put(fajrKey, 0);
    await prayerBox.put(dhuhrKey, 0);
    await prayerBox.put(asrKey, 0);
    await prayerBox.put(maghribKey, 0);
    await prayerBox.put(ishaKey, 0);
    await prayerBox.put(maxFajrKey, 1);
    await prayerBox.put(maxDhuhrKey, 1);
    await prayerBox.put(maxAsrKey, 1);
    await prayerBox.put(maxMaghribKey, 1);
    await prayerBox.put(maxIshaKey, 1);
    // Fasting
    await prayerBox.put(fastingKey, 0);
    await prayerBox.put(maxFastingKey, 1);
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

  Future setQadaaEveryDay(String? count) async {
    await prayerBox.put("qadaaEveryDay", count ?? 1);
  }

  Future resetQadaaEveryDay() async {
    await prayerBox.put("qadaaEveryDay", 1);
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

  Future setFirstOpen(bool val) async {
    await prayerBox.put("is_${AppConstant.appVersion}_first_open", val);
  }

  /// ******************************
  /// Settings
  /// ******************************

  Future toggleSplashBackground() async {
    await prayerBox.put(
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

  Future setSplashBackgroundIndex(int index) async {
    await prayerBox.put("SplashBackgroundIndex", index);
  }

  bool get isLockEnabled =>
      prayerBox.get("is_app_locked", defaultValue: false) as bool;

  String get passCode =>
      prayerBox.get("passcode", defaultValue: "0000") as String;

  Future setIsLockEnabled(bool value) async {
    await prayerBox.put("is_app_locked", value);
  }

  Future setPassCode(String passCode) async {
    await prayerBox.put("passcode", passCode);
  }

  static const String _localeKey = "locale";
  Locale? get locale {
    final value = prayerBox.get(_localeKey) as String?;
    if (value == null) return null;
    return Locale(value);
  }

  Future localeChange(Locale locale) async {
    await prayerBox.put(_localeKey, locale.languageCode);
  }

  ///* ******* desktop Window Size ******* */
  static const String desktopWindowSizeKey = "desktopWindowSize";
  Size? get desktopWindowSize {
    const defaultSize = Size(450, 900);
    try {
      final data = jsonDecode(
        prayerBox.get(desktopWindowSizeKey) as String? ??
            '{"width":${defaultSize.width},"height":${defaultSize.height}}',
      ) as Map<String, dynamic>;

      final double width = (data['width'] as num).toDouble();
      final double height = (data['height'] as num).toDouble();

      return Size(width, height);
    } catch (e) {
      qadaaPrint(e);
    }
    return defaultSize;
  }

  Future<void> changeDesktopWindowSize(Size value) async {
    final screenSize = {
      'width': value.width,
      'height': value.height,
    };
    final String data = jsonEncode(screenSize);
    return prayerBox.put(desktopWindowSizeKey, data);
  }
}
