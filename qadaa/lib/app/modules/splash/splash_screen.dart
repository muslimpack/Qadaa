import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/modules/splash/gradient_linear_progress_indicator.dart';
import 'package:qadaa/app/modules/splash/splash_controller.dart';
import 'package:qadaa/app/shared/enum/sound_type.dart';
import 'package:qadaa/app/shared/functions/print.dart';
import 'package:qadaa/app/shared/widgets/custom_sleek.dart';
import 'package:qadaa/core/values/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              if (controller.splash == "لون ثابت")
                const SizedBox()
              else
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppConstant.splashImages[controller.rImage!],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  alignment: Alignment.center,
                  // color: Colors.grey.withOpacity(0.1),
                  child: const Text(""),
                ),
              ),
              Center(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        controller.prayersController.addFasting(days: -1);
                        qadaaPrint("GestureDetector");
                        await controller.effectManager.playConfetti();
                        controller.update();
                      },
                      onLongPress: () {
                        controller.prayersController.addFasting(days: 1);
                        controller.update();
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "الصوم: باقي ${controller.prayersController.fastingDifference().inDays} أيام \n${controller.prayersController.getFastingEndDateText()}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      height: 2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              GradientLinearProgressIndicator(
                                progressValue:
                                    controller.prayersController.getFasting() /
                                        controller.prayersController
                                            .getMaxFasting(),
                                height: 10,
                                trackHeight: 5,
                                backgroundColor: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue,
                                    AppConstant.mainColor,
                                  ], // Replace with your desired gradient colors.
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CircleIndicator(
                      title: "الأيام المتبقية",
                      initialValue: controller.prayersController.getDays(),
                      max: controller.prayersController.getDaysMax(),
                      onTap: () async {
                        controller.prayersController.addDay(value: -1);

                        await controller.effectManager.playConfetti();

                        controller.update();
                      },
                      onLongTap: () {
                        controller.prayersController.addDay(value: 1);
                        controller.update();
                      },
                      size: size.width * .7,
                      tFontSize: 35,
                      vFontSize: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SinglePrayCircleIndicator(
                          size: size,
                          controller: controller,
                          title: "الفجر",
                          initialValue: controller.prayersController.getFajr(),
                          max: controller.prayersController.getMaxFajr(),
                          onTap: () {
                            controller.prayersController.addPrayer(fajr: -1);
                          },
                          onLongTap: () {
                            controller.prayersController.addPrayer(fajr: 1);
                          },
                        ),
                        SinglePrayCircleIndicator(
                          size: size,
                          controller: controller,
                          title: "الظهر",
                          initialValue: controller.prayersController.getDhuhr(),
                          max: controller.prayersController.getMaxDhuhr(),
                          onTap: () {
                            controller.prayersController.addPrayer(dhuhr: -1);
                          },
                          onLongTap: () {
                            controller.prayersController.addPrayer(dhuhr: 1);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SinglePrayCircleIndicator(
                          size: size,
                          controller: controller,
                          title: "العصر",
                          initialValue: controller.prayersController.getAsr(),
                          max: controller.prayersController.getMaxAsr(),
                          onTap: () {
                            controller.prayersController.addPrayer(asr: -1);
                          },
                          onLongTap: () {
                            controller.prayersController.addPrayer(asr: 1);
                          },
                        ),
                        SinglePrayCircleIndicator(
                          size: size,
                          controller: controller,
                          title: "المغرب",
                          initialValue:
                              controller.prayersController.getMaghrib(),
                          max: controller.prayersController.getMaxMaghrib(),
                          onTap: () {
                            controller.prayersController.addPrayer(maghrib: -1);
                          },
                          onLongTap: () {
                            controller.prayersController.addPrayer(maghrib: 1);
                          },
                        ),
                        SinglePrayCircleIndicator(
                          size: size,
                          controller: controller,
                          title: "العشاء",
                          initialValue: controller.prayersController.getIsha(),
                          max: controller.prayersController.getMaxIsha(),
                          onTap: () {
                            controller.prayersController.addPrayer(isha: -1);
                          },
                          onLongTap: () {
                            controller.prayersController.addPrayer(isha: 1);
                          },
                        ),
                      ],
                    ),
                    const Center(
                      child: Text(
                        "عَنْ عَائِشَةَ أَنَّ رَسُولَ اللَّهِ صَلَّى اللَّهم عَلَيْهِ وَسَلَّمَ قَال\nَ سَدِّدُوا وَقَارِبُوا وَاعْلَمُوا أَنْ لَنْ يُدْخِلَ أَحَدَكُمْ عَمَلُهُ الْجَنَّةَ \nوَأَنَّ أَحَبَّ الْأَعْمَالِ إِلَى اللَّهِ أَدْوَمُهَا وَإِنْ قَلَّ ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Text(
                        controller.prayersController.getPrayerEndDateText(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SinglePrayCircleIndicator extends StatelessWidget {
  final Size size;
  final double sizeFactor;
  final String title;
  final int initialValue;
  final int max;
  final Function() onTap;
  final Function() onLongTap;
  final SplashController controller;
  const SinglePrayCircleIndicator({
    super.key,
    required this.size,
    this.sizeFactor = .3,
    required this.title,
    required this.initialValue,
    required this.max,
    required this.onTap,
    required this.onLongTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CircleIndicator(
        title: title,
        initialValue: initialValue,
        max: max,
        onTap: () async {
          onTap();

          await controller.effectManager.playConfetti(
            alignment: Alignment.center,
            soundType: SoundType.small,
          );
          controller.update();
        },
        size: size.width * .3,
        tFontSize: 15,
        vFontSize: 15,
        onLongTap: () {
          onLongTap();
          controller.update();
        },
      ),
    );
  }
}
