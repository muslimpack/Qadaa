import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/shared/dialogs/delete_days_dialog.dart';
import 'package:qadaa/core/utils/effect_manager.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/shared/tile.dart';
import 'package:qadaa/src/features/splash/presentation/components/fasting_card.dart';

class FastingPage extends StatelessWidget {
  const FastingPage({super.key});

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
                FastingCard(
                  onUpdate: () => controller.update(),
                ),
                const Divider(),
                MyTile(
                  title: S.of(context).done_day,
                  icon: Icons.done,
                  trailing: controller.getFasting().toString(),
                  onTap: () async {
                    controller.addFasting(days: -1);
                    await effectManager.playConfetti();
                    controller.update();
                  },
                ),
                MyTile(
                  title: S.of(context).done_days,
                  icon: Icons.done,
                  trailing: controller.getFasting().toString(),
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

                            controller.addFasting(days: -value);
                            await effectManager.playConfetti();
                            controller.update();
                          },
                        );
                      },
                    );
                  },
                ),
                const Divider(),
                MyTile(
                  title: S.of(context).add_day,
                  icon: Icons.done,
                  trailing: controller.getFasting().toString(),
                  onTap: () async {
                    controller.addFasting(days: 1);
                  },
                ),
                MyTile(
                  title: S.of(context).add_days,
                  icon: Icons.done,
                  trailing: controller.getFasting().toString(),
                  onTap: () async {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteDaysDialog(
                          title: S.of(context).add_days,
                          onConfirm: (value) async {
                            if (value <= 0) return;

                            controller.addFasting(days: value);
                            controller.update();
                          },
                        );
                      },
                    );
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
