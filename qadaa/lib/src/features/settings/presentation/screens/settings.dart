import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:get/get.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/enum/splash_background.dart';
import 'package:qadaa/src/core/shared/dialogs/yes__no_popup.dart';
import 'package:qadaa/src/core/shared/scroll_glow_remover.dart';
import 'package:qadaa/src/core/shared/tile.dart';
import 'package:qadaa/src/core/utils/show_toast.dart';
import 'package:qadaa/src/features/settings/presentation/components/change_prayer_card.dart';
import 'package:qadaa/src/features/settings/presentation/components/custom_title.dart';
import 'package:qadaa/src/features/settings/presentation/components/splash_background_gallery.dart';
import 'package:qadaa/src/features/settings/presentation/controller/settings_controller.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: settingsController,
      builder: (controller) {
        return ScrollGlowRemover(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(S.of(context).settings),
            ),
            body: ListView(
              padding: const EdgeInsets.only(bottom: 70).copyWith(
                left: 10,
                right: 10,
              ),
              children: [
                CustomTitle(title: S.of(context).app_lang),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(S.of(context).app_lang),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Wrap(
                      spacing: 8.0, // Spacing between chips
                      runSpacing: 4.0, // Spacing between rows of chips
                      children: S.delegate.supportedLocales
                          .map(
                            (locale) => ChoiceChip(
                              selected: controller.locale?.languageCode ==
                                  locale.languageCode,
                              label: Text(locale.languageCode),
                              onSelected: (value) {
                                controller.changeThemeLocale(locale);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                CustomTitle(title: S.of(context).app_lock),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  child: Card(
                    child: SwitchListTile(
                      title: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.lock),
                        title: Text(S.of(context).activate_app_lock),
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
                        title: Text(S.of(context).app_lock_reset_password),
                        subtitle: Text(
                          "${S.of(context).app_lock_default_password}: 0000",
                        ),
                        onTap: () {
                          screenLock(
                            title:
                                Text(S.of(context).app_lock_enter_old_password),
                            context: context,
                            correctString: controller.passCode,
                            onUnlocked: () {
                              Navigator.pop(context);
                              screenLock(
                                title: Text(
                                  S.of(context).app_lock_enter_new_password,
                                ),
                                // confirmTitle:
                                //     const Text('أعد إدخال كلمة المرور'),
                                context: context,
                                correctString: controller.passCode,
                                // confirmation: true,
                                onValidate: (matchedText) async {
                                  controller.setPassCode(matchedText);
                                  // Navigator.pop(context);
                                  showToast(
                                    S.of(context).app_lock_password_reset_done,
                                  );
                                  return true;
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                CustomTitle(title: S.of(context).prayer_Settings),
                ChangePrayersCard(
                  settingsController: controller,
                ),
                CustomTitle(title: S.of(context).ui),
                MyTile(
                  title: S.of(context).splash_background,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                CustomTitle(title: S.of(context).other_settings),
                MyTile(
                  title: S.of(context).reset_everything,
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
                ListTile(
                  title: Text(
                    '${S.of(context).version} ${AppConstant.appVersion}',
                    textAlign: TextAlign.center,
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
