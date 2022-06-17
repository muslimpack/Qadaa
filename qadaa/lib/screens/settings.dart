import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/Shared/Widgets/Tile.dart';
import 'package:qadaa/controllers/settings_controller.dart';
import 'package:qadaa/shared/dialogs/yes__no_popup.dart';
import 'package:qadaa/shared/widgets/user_text_field.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  Widget count(SettingsController settingsController) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              child: Text(
                "عدد صلوات القضاء اليومية",
                textAlign: TextAlign.center,
              ),
            ),
            UserTextFieldChanged(
              controller: settingsController.qadaaController,
              hintText: "عدد صلوات القضاء اليومية ",
              onChange: (count) {
                if (count.isNotEmpty) {
                  settingsController.prayersController.setqadaaEveryDay(count);
                  settingsController.update();
                }
              },
            ),
            Text(
              settingsController.prayersController.getEndDateText(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue.shade200),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text("الإعدادات"),
            ),
            body: ListView(
              children: [
                const Title(title: "عام"),
                count(controller),
                const Divider(),
                MyTile(
                  title: 'صفحة البدء',
                  icon: Icons.palette_outlined,
                  onTap: () {
                    controller.toggleSplashBackground();
                  },
                  trailing: controller.getSplashBackground(),
                ),
                MyTile(
                  title: 'إعادة ضبط كل شيء',
                  icon: Icons.delete_forever,
                  trailing: "",
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return YesOrNoDialog(
                            onYes: () {
                              controller.prayersController.reset();
                              controller.prayersController.resetqadaaEveryDay();
                              controller.prayersController.update();
                              controller.qadaaController =
                                  TextEditingController(text: "1");
                              controller.update();
                            },
                          );
                        });
                  },
                )
              ],
            ),
          );
        });
  }
}

class Title extends StatelessWidget {
  final String title;

  const Title({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(Icons.bookmark_border),

      title: Text(
        title,
        style: const TextStyle(fontSize: 20, color: Colors.pink),
      ),
    );
  }
}
