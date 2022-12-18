import 'dart:math';
import 'package:get/get.dart';
import 'package:qadaa/app/modules/settings/settings_controller.dart';
import 'package:qadaa/core/utils/effect_manager.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';
import 'package:wakelock/wakelock.dart';

class SplashController extends GetxController {
  /* *************** Variables *************** */
  final EffectManager effectManager = Get.put(EffectManager());
  final SettingsController settingsController = Get.put(SettingsController());
  final PrayersController prayersController = Get.put(PrayersController());
  String? splash = "";
  static final _random = Random();
  var today = DateTime.now();
  int? rImage = 0;
  /* *************** Controller life cycle *************** */
  @override
  void onInit() async {
    super.onInit();
    rImage = _random.nextInt(4).toInt();

    splash = settingsController.getSplashBackground();

    Wakelock.enable();
    update();
  }

  @override
  void onClose() {
    Wakelock.disable();
    super.onClose();
  }

  /* *************** Functions *************** */

}
