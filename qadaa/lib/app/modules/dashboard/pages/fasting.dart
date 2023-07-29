import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/modules/splash/splash_screen.dart';
import 'package:qadaa/app/shared/dialogs/delete_days_dialog.dart';
import 'package:qadaa/app/shared/widgets/tile.dart';
import 'package:qadaa/core/utils/effect_manager.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';

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
                  title: "قضيت يومًا",
                  icon: Icons.done,
                  trailing: controller.getFasting().toString(),
                  onTap: () async {
                    controller.addFasting(days: -1);
                    await effectManager.playConfetti();
                    controller.update();
                  },
                ),
                MyTile(
                  title: "قضيت أيامًا",
                  icon: Icons.done,
                  trailing: controller.getFasting().toString(),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteDaysDialog(
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
                  title: "أضف يوما",
                  icon: Icons.done,
                  trailing: controller.getFasting().toString(),
                  onTap: () async {
                    controller.addFasting(days: 1);
                  },
                ),
                MyTile(
                  title: "أضف أيامًا",
                  icon: Icons.done,
                  trailing: controller.getFasting().toString(),
                  onTap: () async {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteDaysDialog(
                          title: "أضف أيامًا",
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
