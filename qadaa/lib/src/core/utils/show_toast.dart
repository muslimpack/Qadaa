import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qadaa/generated/l10n.dart';

void showToast(String message) {
  Get.snackbar(
    S.current.qadaa,
    message,
    icon: Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Image.asset("assets/images/app_icon.png"),
    ),
  );
}
