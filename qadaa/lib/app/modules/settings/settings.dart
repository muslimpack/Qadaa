import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/modules/settings/settings_controller.dart';
import 'package:qadaa/app/modules/settings/widgets/change_prayer_card.dart';
import 'package:qadaa/app/modules/settings/widgets/custom_title.dart';
import 'package:qadaa/app/modules/settings/widgets/splash_background_gallery.dart';
import 'package:qadaa/app/shared/dialogs/yes__no_popup.dart';
import 'package:qadaa/app/shared/enum/splash_background.dart';
import 'package:qadaa/app/shared/functions/show_toast.dart';
import 'package:qadaa/app/shared/widgets/scroll_glow_remover.dart';
import 'package:qadaa/app/shared/widgets/tile.dart';
import 'package:qadaa/core/values/constant.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
              padding: const EdgeInsets.only(bottom: 70).copyWith(
                left: 10,
                right: 10,
              ),
              children: [
                const CustomTitle(title: "قفل التطبيق"),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  child: Card(
                    child: SwitchListTile(
                      title: const ListTile(
                        contentPadding: EdgeInsets.zero,
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
                if (!controller.isLockEnabled)
                  const SizedBox()
                else
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.password),
                        title: const Text("اضغط لتعيين كلمة المرور"),
                        subtitle: const Text("كلمة المرور الافتراضية: 0000"),
                        onTap: () {
                          screenLock(
                            title: const Text('أدخل كلمة المرور القديمة'),
                            context: context,
                            correctString: controller.passCode,
                            onUnlocked: () {
                              Navigator.pop(context);
                              screenLock(
                                title: const Text('أدخل كلمة المرور الجديدة'),
                                // confirmTitle:
                                //     const Text('أعد إدخال كلمة المرور'),
                                context: context,
                                correctString: controller.passCode,
                                // confirmation: true,
                                onValidate: (matchedText) async {
                                  controller.setPassCode(matchedText);
                                  // Navigator.pop(context);
                                  showToast("تم إعادة تعيين كلمة المرور");
                                  return true;
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                const CustomTitle(title: "إعدادات الصلاة"),
                ChangePrayersCard(
                  settingsController: controller,
                ),
                const CustomTitle(title: "الواجهة"),
                MyTile(
                  title: 'صفحة البدء',
                  icon: Icons.palette_outlined,
                  onTap: () {
                    controller.toggleSplashBackground();
                  },
                  trailing: controller.getSplashBackground().toArabic(),
                ),
                if (controller.getSplashBackground() ==
                    SplashBackGroundEnum.staticImage)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          SplashBackgroundGallery(
                            selectedIndex:
                                controller.getSplashBackgroundIndex(),
                            onSelect: (index) {
                              controller.setSplashBackgroundIndex(index);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                const CustomTitle(title: "أخرى"),
                MyTile(
                  title: 'إعادة ضبط كل شيء',
                  icon: Icons.delete_forever,
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return YesOrNoDialog(
                          onYes: () {
                            controller.prayersController.reset();
                            controller.prayersController.resetQadaaEveryDay();
                            controller.prayersController.update();
                            controller.setPassCode("0000");
                            controller.qadaaController =
                                TextEditingController(text: "1");
                            controller.update();
                          },
                        );
                      },
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        'تطبيق قضاء الإصدار ${AppConstant.appVersion}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
