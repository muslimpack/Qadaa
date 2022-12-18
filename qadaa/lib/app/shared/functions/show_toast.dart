import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void showToast(message) {
  Get.snackbar("قضاء", message,
      icon: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Image.asset("assets/images/app_icon.png"),
      ));
}
