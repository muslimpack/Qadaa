import 'dart:math';
import 'package:qadaa/manager/awesome_notification_manager.dart';
import 'package:qadaa/manager/constant.dart';

showRandomNotification() async {
  Random randomNumberGenerator = Random();
  int num = randomNumberGenerator.nextInt(2);
  if (num == 1) {
    await awesomeNotificationManager.showCustomNotification(
        title: AppConstant.motivateMsg[
            randomNumberGenerator.nextInt(AppConstant.motivateMsg.length)],
        body: "ذَٰلِكَ الْفَضْلُ مِنَ اللَّهِ ۚ وَكَفَىٰ بِاللَّهِ عَلِيمًا",
        payload: "استعن بالله ولا تعجز");
  }
}
