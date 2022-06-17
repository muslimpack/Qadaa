import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/manager/notification_manager.dart';

class AppDashboardController extends GetxController {
  /* *************** Variables *************** */

  late final PageController pageController;
  int currentPageIndex = 0;
  bool isLoading = true;
  /* *************** Controller life cycle *************** */

  @override
  void onReady() {
    //                if (Hive.box("Prayers").get("is_app_locked", defaultValue: false)) {
    // screenLock(
    //   title: const HeadingTitle(text: 'أدخل كلمة المرور القديمة'),
    //   context: context,
    //   correctString:
    //       Hive.box("Prayers").get("passcode", defaultValue: "0000"),
    //   didUnlocked: () {
    //     Navigator.pop(context);
    //   },
    // );
    // }
    super.onReady();
    if (Hive.box("Prayers").get("is_app_locked", defaultValue: false)) {
      screenLock(
        context: Get.context!,
        title: const Text("أدخل كلمة السر"),
        screenLockConfig: const ScreenLockConfig(
            backgroundColor: Color.fromARGB(255, 16, 35, 56)),
        correctString:
            Hive.box("Prayers").get("passcode", defaultValue: "0000"),
        canCancel: false,
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    pageController = PageController(initialPage: 0);
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
    isLoading = false;
    update();
  }

  /* *************** Functions *************** */
  onNotificationReceive(ReceiveNotification notification) {
    DoNothingAction();
  }

  onNotificationClick(String payload) {
    DoNothingAction();
  }
}
