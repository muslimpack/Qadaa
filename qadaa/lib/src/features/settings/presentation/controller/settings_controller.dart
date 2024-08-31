import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/enum/splash_background.dart';
import 'package:qadaa/src/core/managers/prayer_controller.dart';
import 'package:qadaa/src/core/managers/storage_repo.dart';

SettingsController settingsController = SettingsController();

class SettingsController extends GetxController {
  /* *************** Variables *************** */
  late TextEditingController qadaaController;
  final PrayersController prayersController = Get.put(PrayersController());

  final prayerBox = Hive.box(kAppStorageBoxName);

  /* *************** Controller life cycle *************** */
  @override
  void onInit() {
    super.onInit();
    qadaaController =
        TextEditingController(text: prayersController.getQadaaEveryDay());
  }

  /* *************** Functions *************** */
  // First Screen
  void toggleSplashBackground() {
    storageRepo.toggleSplashBackground();
    update();
  }

  SplashBackGroundEnum getSplashBackground() {
    return storageRepo.getSplashBackground();
  }

  int getSplashBackgroundIndex() {
    return storageRepo.getSplashBackgroundIndex();
  }

  void setSplashBackgroundIndex(int index) {
    storageRepo.setSplashBackgroundIndex(index);
    update();
  }

  bool get isLockEnabled => storageRepo.isLockEnabled;

  String get passCode => storageRepo.passCode;

  void setIsLockEnabled(bool value) {
    storageRepo.setIsLockEnabled(value);
    update();
  }

  void setPassCode(String passCode) {
    storageRepo.setPassCode(passCode);
    update();
  }

  Locale? get locale => storageRepo.locale;

  Future changeThemeLocale(Locale locale) async {
    await storageRepo.localeChange(locale);
    Get.updateLocale(locale);
  }
}
