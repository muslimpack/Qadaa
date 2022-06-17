import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:qadaa/Shared/Widgets/Tile.dart';
import 'package:qadaa/controllers/settings_controller.dart';
import 'package:qadaa/shared/constants.dart';
import 'package:qadaa/shared/dialogs/yes__no_popup.dart';
import 'package:qadaa/shared/functions/show_toast.dart';
import 'package:qadaa/shared/widgets/scroll_glow_remover.dart';
import 'package:qadaa/shared/widgets/user_text_field.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          return ScrollGlowRemover(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text("الإعدادات"),
              ),
              body: ListView(
                children: [
                  const Title(title: "عام"),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    child: Card(
                      child: SwitchListTile(
                        title: const ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: Icon(Icons.lock),
                          title: Text("تفعيل قفل التطبيق"),
                        ),
                        activeColor: Colors.pink,
                        value: controller.isLockEnabled,
                        onChanged: (value) {
                          controller.setIsLockEnabled(value);
                        },
                      ),
                    ),
                  ),
                  !controller.isLockEnabled
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7),
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Card(
                            child: ListTile(
                              leading: const Icon(Icons.password),
                              title: const Text("اضغط لتعيين كلمة المرور"),
                              subtitle:
                                  const Text("كلمة المرور الافتراضية: 0000"),
                              onTap: () {
                                screenLock(
                                  title: const HeadingTitle(
                                      text: 'أدخل كلمة المرور القديمة'),
                                  context: context,
                                  correctString: controller.passCode,
                                  didUnlocked: () {
                                    Navigator.pop(context);
                                    screenLock(
                                      title: const HeadingTitle(
                                          text: 'أدخل كلمة المرور الجديدة'),
                                      confirmTitle: const HeadingTitle(
                                          text: 'أعد إدخال كلمة المرور'),
                                      context: context,
                                      correctString: controller.passCode,
                                      confirmation: true,
                                      didConfirmed: (matchedText) {
                                        // ignore: avoid_print
                                        print(matchedText);
                                        controller.setPasscode(matchedText);
                                        Navigator.pop(context);
                                        showToast("تم إعادة تعيين كلمة المرور");
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                  ChangePrayersCard(
                    settingsController: controller,
                  ),
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
                                controller.prayersController
                                    .resetqadaaEveryDay();
                                controller.prayersController.update();
                                controller.setPasscode("0000");
                                controller.qadaaController =
                                    TextEditingController(text: "1");
                                controller.update();
                              },
                            );
                          });
                    },
                  ),
                  const Divider(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    padding: const EdgeInsets.only(bottom: 5),
                    child: const Card(
                      child: ListTile(
                        title: Text(
                          'تطبيق قضاء الإصدار $appVersion',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ChangePrayersCard extends StatelessWidget {
  final SettingsController settingsController;
  const ChangePrayersCard({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
