import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/modules/dashboard/widgets/my_divider.dart';
import 'package:qadaa/app/shared/dialogs/delete_days_dialog.dart';
import 'package:qadaa/app/shared/dialogs/delete_prayers_dialog.dart';
import 'package:qadaa/app/shared/enum/sound_type.dart';
import 'package:qadaa/app/shared/functions/random_notification.dart';
import 'package:qadaa/app/shared/widgets/tile.dart';
import 'package:qadaa/core/utils/effect_manager.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';
import 'package:qadaa/generated/l10n.dart';

class Done extends StatelessWidget {
  const Done({super.key});

  @override
  Widget build(BuildContext context) {
    final effectManager = Get.put(EffectManager());
    return GetBuilder<PrayersController>(
      builder: (controller) {
        return Scrollbar(
          thumbVisibility: false,
          child: Scaffold(
            body: ListView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 70).copyWith(
                left: 10,
                right: 10,
              ),
              children: [
                const SizedBox(height: 10),
                MyDivider(title: S.of(context).periods_done_title),
                MyTile(
                  title: S.of(context).day,
                  icon: Icons.done,
                  trailing: controller.getDays().toString(),
                  onTap: () async {
                    if (controller.getDays() > 0) {
                      controller.addDay(value: -1);
                      showRandomNotification();
                      await effectManager.playConfetti(
                        milliseconds: 5000,
                      );
                    }
                  },
                ),
                MyTile(
                  title: S.of(context).days,
                  icon: Icons.done,
                  trailing: controller.getDays().toString(),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteDaysDialog(
                          title: S.of(context).done_days,
                          onConfirm: (value) async {
                            if (value <= 0) return;

                            if (controller.getDays() > 0) {
                              controller.addDay(
                                value: -value,
                              );
                              showRandomNotification();
                            }

                            await effectManager.playConfetti(
                              milliseconds: 5000,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                MyDivider(title: S.of(context).prayers_done_title),
                MyTile(
                  title: S.of(context).fajr,
                  icon: Icons.done,
                  trailing: controller.getFajr().toString(),
                  onTap: () async {
                    controller.addPrayer(fajr: -1);

                    await effectManager.playConfetti(
                      alignment: Alignment.center,
                      soundType: SoundType.small,
                    );
                  },
                ),
                MyTile(
                  title: S.of(context).dhuhr,
                  icon: Icons.done,
                  trailing: controller.getDhuhr().toString(),
                  onTap: () async {
                    controller.addPrayer(dhuhr: -1);

                    await effectManager.playConfetti(
                      alignment: Alignment.center,
                      soundType: SoundType.small,
                    );
                  },
                ),
                MyTile(
                  title: S.of(context).asr,
                  icon: Icons.done,
                  trailing: controller.getAsr().toString(),
                  onTap: () async {
                    controller.addPrayer(asr: -1);

                    await effectManager.playConfetti(
                      alignment: Alignment.center,
                      soundType: SoundType.small,
                    );
                  },
                ),
                MyTile(
                  title: S.of(context).maghrib,
                  icon: Icons.done,
                  trailing: controller.getMaghrib().toString(),
                  onTap: () async {
                    controller.addPrayer(maghrib: -1);

                    await effectManager.playConfetti(
                      alignment: Alignment.center,
                      soundType: SoundType.small,
                    );
                  },
                ),
                MyTile(
                  title: S.of(context).ishaa,
                  icon: Icons.done,
                  trailing: controller.getIsha().toString(),
                  onTap: () async {
                    controller.addPrayer(isha: -1);

                    await effectManager.playConfetti(
                      alignment: Alignment.center,
                      soundType: SoundType.small,
                    );
                  },
                ),
                MyTile(
                  title: S.of(context).custom_done_prayers,
                  icon: Icons.done,
                  trailing: controller.getAllRemainingPrayer().toString(),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return const DeletePrayersDialog();
                      },
                    ).then((value) async {
                      await effectManager.playConfetti();
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
