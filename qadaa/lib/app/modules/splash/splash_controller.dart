import 'dart:math';
import 'package:get/get.dart';
import 'package:qadaa/app/modules/settings/settings_controller.dart';
import 'package:qadaa/app/shared/enum/splash_background.dart';
import 'package:qadaa/core/utils/effect_manager.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';
import 'package:qadaa/core/utils/storage_repo.dart';
import 'package:qadaa/core/values/constant.dart';
import 'package:wakelock/wakelock.dart';

class SplashController extends GetxController {
  /* *************** Variables *************** */
  final EffectManager effectManager = Get.put(EffectManager());
  final SettingsController mySettingsController = Get.put(settingsController);
  final PrayersController prayersController = Get.put(PrayersController());
  SplashBackGroundEnum? splashBackGroundEnum;
  static final _random = Random();
  DateTime today = DateTime.now();
  late final int rImage;
  late final int rMsg;
  /* *************** Controller life cycle *************** */
  @override
  Future<void> onInit() async {
    super.onInit();

    if (storageRepo.getSplashBackground() == SplashBackGroundEnum.randomImage) {
      rImage = _random.nextInt(AppConstant.splashImages.length);
    } else {
      rImage = storageRepo.getSplashBackgroundIndex();
    }

    rMsg = _random.nextInt(AppConstant.splashMsg.length);

    splashBackGroundEnum = mySettingsController.getSplashBackground();

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
