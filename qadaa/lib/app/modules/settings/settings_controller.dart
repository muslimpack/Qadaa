import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/app/shared/enum/splash_background.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';
import 'package:qadaa/core/utils/storage_repo.dart';

class SettingsController extends GetxController {
  /* *************** Variables *************** */
  late TextEditingController qadaaController;
  final PrayersController prayersController = Get.put(PrayersController());

  final prayerBox = Hive.box("Prayers");

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
}
