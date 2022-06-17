import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QadaaController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /* *************** Variables *************** */
  late TabController tabController;
  late PageController pageController;
  bool isLoading = true;
  /* *************** Controller life cycle *************** */

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 1);
    tabController = TabController(initialIndex: 1, length: 2, vsync: this);
    isLoading = false;
    update();
  }

  /* *************** Functions *************** */

}
