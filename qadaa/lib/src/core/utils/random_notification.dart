import 'dart:math';

import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/managers/awesome_notification_manager.dart';

Future<void> showRandomNotification() async {
  final Random randomNumberGenerator = Random();
  final int num = randomNumberGenerator.nextInt(2);
  if (num == 1) {
    await awesomeNotificationManager.showCustomNotification(
      title: AppConstant.motivateMsg[
          randomNumberGenerator.nextInt(AppConstant.motivateMsg.length)],
      body: "ذَٰلِكَ الْفَضْلُ مِنَ اللَّهِ ۚ وَكَفَىٰ بِاللَّهِ عَلِيمًا",
      payload: "استعن بالله ولا تعجز",
    );
  }
}
