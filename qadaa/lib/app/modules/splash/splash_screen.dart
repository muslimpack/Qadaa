import 'dart:ui';

import 'package:get/get.dart';
import 'package:qadaa/app/modules/splash/splash_controller.dart';
import 'package:qadaa/app/shared/enum/sound_type.dart';
import 'package:qadaa/app/shared/widgets/custom_sleek.dart';
import 'package:qadaa/core/values/constant.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                controller.splash == "لون ثابت"
                    ? const SizedBox()
                    : Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                AppConstant.splashImages[controller.rImage!]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.grey.withOpacity(0.1),
                    child: const Text(""),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleIndicator(
                          title: "الأيام المتبقية",
                          initialValue: controller.prayersController.getDays(),
                          max: controller.prayersController.getDaysMax(),
                          onTap: () {
                            controller.prayersController.addDay(value: -1);

                            controller.effectManager.playConfetti(
                                milliseconds: 1000,
                                alignment: Alignment.topCenter,
                                soundType: SoundType.big);

                            controller.update();
                          },
                          onLongTap: () {
                            controller.prayersController.addDay(value: 1);
                            controller.update();
                          },
                          size: size.width * .7,
                          tFontSize: 35,
                          vFontSize: 70),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleIndicator(
                              title: "الفجر",
                              initialValue:
                                  controller.prayersController.getFajr(),
                              max: controller.prayersController.getMaxFajr(),
                              onTap: () {
                                controller.prayersController
                                    .addPrayer(fajr: -1);

                                controller.effectManager.playConfetti(
                                    milliseconds: 1000,
                                    alignment: Alignment.center,
                                    soundType: SoundType.small);
                                controller.update();
                              },
                              size: size.width * .3,
                              tFontSize: 15,
                              vFontSize: 15,
                              onLongTap: () {
                                controller.prayersController.addPrayer(fajr: 1);
                                controller.update();
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: CircleIndicator(
                                title: "الظهر",
                                initialValue:
                                    controller.prayersController.getDhuhr(),
                                max: controller.prayersController.getMaxDhuhr(),
                                onTap: () {
                                  controller.prayersController
                                      .addPrayer(dhuhr: -1);

                                  controller.effectManager.playConfetti(
                                      milliseconds: 1000,
                                      alignment: Alignment.center,
                                      soundType: SoundType.small);
                                  controller.update();
                                },
                                onLongTap: () {
                                  controller.prayersController
                                      .addPrayer(dhuhr: 1);
                                  controller.update();
                                },
                                size: size.width * .3,
                                tFontSize: 15,
                                vFontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleIndicator(
                                title: "العصر",
                                initialValue:
                                    controller.prayersController.getAsr(),
                                max: controller.prayersController.getMaxAsr(),
                                onTap: () {
                                  controller.prayersController
                                      .addPrayer(asr: -1);

                                  controller.effectManager.playConfetti(
                                      milliseconds: 1000,
                                      alignment: Alignment.center,
                                      soundType: SoundType.small);
                                  controller.update();
                                },
                                onLongTap: () {
                                  controller.prayersController
                                      .addPrayer(asr: 1);
                                  controller.update();
                                },
                                size: size.width * .25,
                                tFontSize: 15,
                                vFontSize: 15),
                          ),
                          Expanded(
                            flex: 1,
                            child: CircleIndicator(
                                title: "المغرب",
                                initialValue:
                                    controller.prayersController.getMaghrib(),
                                max: controller.prayersController
                                    .getMaxMaghrib(),
                                onTap: () {
                                  controller.prayersController
                                      .addPrayer(maghrib: -1);

                                  controller.effectManager.playConfetti(
                                      milliseconds: 1000,
                                      alignment: Alignment.center,
                                      soundType: SoundType.small);
                                  controller.update();
                                },
                                onLongTap: () {
                                  controller.prayersController
                                      .addPrayer(maghrib: 1);
                                  controller.update();
                                },
                                size: size.width * .25,
                                tFontSize: 15,
                                vFontSize: 15),
                          ),
                          Expanded(
                            flex: 1,
                            child: CircleIndicator(
                                title: "العشاء",
                                initialValue:
                                    controller.prayersController.getIsha(),
                                max: controller.prayersController.getMaxIsha(),
                                onTap: () {
                                  controller.prayersController
                                      .addPrayer(isha: -1);

                                  controller.effectManager.playConfetti(
                                      milliseconds: 1000,
                                      alignment: Alignment.center,
                                      soundType: SoundType.small);
                                  controller.update();
                                },
                                onLongTap: () {
                                  controller.prayersController
                                      .addPrayer(isha: 1);
                                  controller.update();
                                },
                                size: size.width * .25,
                                tFontSize: 15,
                                vFontSize: 15),
                          ),
                        ],
                      ),
                      const Center(
                        child: Text(
                          "عَنْ عَائِشَةَ أَنَّ رَسُولَ اللَّهِ صَلَّى اللَّهم عَلَيْهِ وَسَلَّمَ قَال\nَ سَدِّدُوا وَقَارِبُوا وَاعْلَمُوا أَنْ لَنْ يُدْخِلَ أَحَدَكُمْ عَمَلُهُ الْجَنَّةَ \nوَأَنَّ أَحَبَّ الْأَعْمَالِ إِلَى اللَّهِ أَدْوَمُهَا وَإِنْ قَلَّ ",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          controller.prayersController.getEndDateText(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade200),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
