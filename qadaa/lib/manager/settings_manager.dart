import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

SettingsManager settingsManager = SettingsManager();

class SettingsManager {
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

  // qadaa every day
  String getqadaaEveryDay() {
    String? data =
        Hive.box("Prayers").get("qadaaEveryDay", defaultValue: "1").toString();
    debugPrint("getqadaaEveryDay: " + data);
    return data == "0" ? "1" : data;
  }

  setqadaaEveryDay(String? count) {
    Hive.box("Prayers").put("qadaaEveryDay", count ?? 1);
    debugPrint("setqadaaEveryDay: " + count!);
  }

  resetqadaaEveryDay() {
    Hive.box("Prayers").put("qadaaEveryDay", 1);
  }
}
