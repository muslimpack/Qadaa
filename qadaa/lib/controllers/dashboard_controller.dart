import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/manager/notification_manager.dart';

class AppDashboardController extends GetxController {
  /* *************** Variables *************** */

  late final PageController pageController;
  int currentPageIndex = 0;
  bool isLoading = true;
  /* *************** Controller life cycle *************** */
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
