import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';

class SettingsController extends GetxController {
  /* *************** Variables *************** */
  late TextEditingController qadaaController;
  final PrayersController prayersController = Get.put(PrayersController());
  bool get isLockEnabled =>
      Hive.box("Prayers").get("is_app_locked", defaultValue: false);
  String get passCode =>
      Hive.box("Prayers").get("passcode", defaultValue: "0000");
  /* *************** Controller life cycle *************** */
  @override
  void onInit() {
    super.onInit();
    qadaaController =
        TextEditingController(text: prayersController.getqadaaEveryDay());
  }

  /* *************** Functions *************** */
  // First Screen
  toggleSplashBackground() {
    String value;
    if (Hive.box("Prayers").get("SplashBackground", defaultValue: "صورة") ==
        "صورة") {
      value = "لون ثابت";
    } else {
      value = "صورة";
    }
    Hive.box("Prayers").put("SplashBackground", value);
    update();
  }

  String getSplashBackground() {
    return Hive.box("Prayers")
        .get("SplashBackground", defaultValue: "صورة")
        .toString();
  }

  setIsLockEnabled(bool value) {
    Hive.box("Prayers").put("is_app_locked", value);
    update();
  }

  setPasscode(String passcode) {
    Hive.box("Prayers").put("passcode", passcode);
    update();
  }
}
