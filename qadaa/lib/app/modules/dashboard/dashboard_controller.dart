import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/generated/l10n.dart';

class AppDashboardController extends GetxController {
  /* *************** Variables *************** */

  late final PageController pageController;
  int currentPageIndex = 0;
  bool isLoading = true;
  /* *************** Controller life cycle *************** */

  @override
  void onReady() {
    super.onReady();
    final bool isAppLocked =
        Hive.box("Prayers").get("is_app_locked", defaultValue: false) as bool;
    if (isAppLocked) {
      screenLock(
        context: Get.context!,
        title: Text(S.current.enter_password),
        config: ScreenLockConfig(
          backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        ),
        correctString:
            Hive.box("Prayers").get("passcode", defaultValue: "0000") as String,
        canCancel: false,
      );
    }

    pageController.addListener(() {
      currentPageIndex = (pageController.page ?? 0).toInt();
      update();
    });
  }

  void goUp() {
    pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  void goDown() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    pageController = PageController();
    isLoading = false;
    update();
  }
}
