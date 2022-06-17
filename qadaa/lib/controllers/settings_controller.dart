import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/controllers/prayer_controller.dart';

class SettingsController extends GetxController {
  /* *************** Variables *************** */
  late TextEditingController qadaaController;
  final PrayersController prayersController = Get.put(PrayersController());
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
  }

  String getSplashBackground() {
    return Hive.box("Prayers")
        .get("SplashBackground", defaultValue: "صورة")
        .toString();
  }
}
