import 'package:flutter/material.dart';

AppConstant appConstant = AppConstant();

class AppConstant {
  static Color mainColor = Colors.pink;
  static Color mainColorLight = Colors.pinkAccent;
  static Color scrollColor = Colors.black;

  //TODO edit every release
  static String get appVersion => appVersions.first;
  static List<String> appVersions = ["1.2.0", "1.1.0", "1.0.0"];

  static List<String> notificationBody = [
    "قم وأري الله من نفسك خيرا",
    "القضاء يرحمك الله",
    "أحيي ليلك بفائتك",
  ];

  static List<String> motivateMsg = [
    "أحسنت 💪",
    "تقبل الله صالح أعمالك",
    "بارك الله فيك",
    "أعانك الله",
    "اللهم أعني على ذكرك وشكرك وحسن عبادتك"
  ];

  static List<String> splashImages = [
    "assets/images/0.jpg",
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
  ];
}
