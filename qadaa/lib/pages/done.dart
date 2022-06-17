import 'package:get/get.dart';
import 'package:qadaa/Shared/Widgets/Tile.dart';
import 'package:qadaa/controllers/effect_manager.dart';
import 'package:qadaa/controllers/prayer_controller.dart';
import 'package:qadaa/shared/dialogs/delete_days_dialog.dart';
import 'package:qadaa/shared/dialogs/delete_prayers_dialog.dart';
import 'package:qadaa/shared/enum/sound_type.dart';
import 'package:qadaa/shared/functions/random_notification.dart';
import 'package:flutter/material.dart';

class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectManager = Get.put(EffectManager());
    return GetBuilder<PrayersController>(builder: (controller) {
      return Scaffold(
          body: Scrollbar(
        isAlwaysShown: false,
        child: ListView(
          children: [
            const SizedBox(height: 10),
            MyTile(
              title: "قضيت يومًا",
              icon: Icons.done,
              trailing: controller.getDays().toInt().toString(),
              onTap: () {
                if (controller.getDays() > 0) {
                  controller.addDay(value: -1);
                  showRandomNotification();
                  effectManager.playConfetti(
                      milliseconds: 5000, alignment: Alignment.topCenter);
                }
              },
            ),
            MyTile(
              title: "قضيت أيامًا",
              icon: Icons.done,
              trailing: controller.getDays().toInt().toString(),
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return const DeleteDaysDialog();
                    }).then((value) {
                  effectManager.playConfetti(
                      milliseconds: 5000, alignment: Alignment.topCenter);
                });
              },
            ),
            const Divider(),
            MyTile(
              title: "قضيت صلاة فجر",
              icon: Icons.done,
              trailing: controller.getFajr().toInt().toString(),
              onTap: () {
                controller.addPrayer(fajr: -1);

                effectManager.playConfetti(
                    milliseconds: 1000,
                    alignment: Alignment.center,
                    soundType: SoundType.small);
              },
            ),
            MyTile(
              title: "قضيت صلاة ظهر",
              icon: Icons.done,
              trailing: controller.getDhuhr().toInt().toString(),
              onTap: () {
                controller.addPrayer(dhuhr: -1);

                effectManager.playConfetti(
                    milliseconds: 1000,
                    alignment: Alignment.center,
                    soundType: SoundType.small);
              },
            ),
            MyTile(
              title: "قضيت صلاة عصر",
              icon: Icons.done,
              trailing: controller.getAsr().toInt().toString(),
              onTap: () {
                controller.addPrayer(asr: -1);

                effectManager.playConfetti(
                    milliseconds: 1000,
                    alignment: Alignment.center,
                    soundType: SoundType.small);
              },
            ),
            MyTile(
              title: "قضيت صلاة مغرب",
              icon: Icons.done,
              trailing: controller.getMaghrib().toInt().toString(),
              onTap: () {
                controller.addPrayer(maghrib: -1);

                effectManager.playConfetti(
                    milliseconds: 1000,
                    alignment: Alignment.center,
                    soundType: SoundType.small);
              },
            ),
            MyTile(
              title: "قضيت صلاة عشاء",
              icon: Icons.done,
              trailing: controller.getIsha().toInt().toString(),
              onTap: () {
                controller.addPrayer(isha: -1);

                effectManager.playConfetti(
                    milliseconds: 1000,
                    alignment: Alignment.center,
                    soundType: SoundType.small);
              },
            ),
            MyTile(
              title: "قضيت صلوات",
              icon: Icons.done,
              trailing: (controller.getAllRemainingPrayer()).toInt().toString(),
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return const DeletePrayersDialog();
                    }).then((value) {
                  effectManager.playConfetti(
                      milliseconds: 1000,
                      alignment: Alignment.topCenter,
                      soundType: SoundType.big);
                });
              },
            ),
          ],
        ),
      ));
    });
  }
}
