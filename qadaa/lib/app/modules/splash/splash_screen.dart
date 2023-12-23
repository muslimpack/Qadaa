import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qadaa/app/modules/splash/splash_controller.dart';
import 'package:qadaa/app/modules/splash/widgets/fasting_card.dart';
import 'package:qadaa/app/modules/splash/widgets/single_prayer_circle_indicator.dart';

import 'package:qadaa/app/shared/enum/splash_background.dart';
import 'package:qadaa/app/shared/widgets/custom_sleek.dart';
import 'package:qadaa/core/utils/storage_repo.dart';
import 'package:qadaa/core/values/constant.dart';
import 'package:qadaa/generated/l10n.dart';

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
              () {
                final SplashBackGroundEnum back =
                    storageRepo.getSplashBackground();
                if (back == SplashBackGroundEnum.staticColor) {
                  return const SizedBox();
                }

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppConstant.splashImages[controller.rImage],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }(),
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
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shrinkWrap: true,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FastingCard(
                      onUpdate: () => controller.update(),
                    ),
                    const SizedBox(height: 20),
                    CircleIndicator(
                      title: S.of(context).remaining_days,
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
                      size: size.width * .5,
                      tFontSize: 30,
                      vFontSize: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SinglePrayCircleIndicator(
                          size: size,
                          controller: controller,
                          title: S.of(context).fajr,
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
                          title: S.of(context).dhuhr,
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
                          title: S.of(context).asr,
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
                          title: S.of(context).maghrib,
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
                          title: S.of(context).ishaa,
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          AppConstant.splashMsg[controller.rMsg],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            height: 2,
                          ),
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
