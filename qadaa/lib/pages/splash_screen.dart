import 'dart:math';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:qadaa/controllers/effect_manager.dart';
import 'package:qadaa/controllers/settings_controller.dart';
import 'package:qadaa/manager/constant.dart';
import 'package:qadaa/controllers/prayer_controller.dart';
import 'package:qadaa/shared/enum/sound_type.dart';
import 'package:qadaa/shared/widgets/custom_sleek.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? _splash = "";
  static final _random = Random();
  var today = DateTime.now();
  int? rImage = 0;
  final settingsController = Get.put(SettingsController());
  @override
  void initState() {
    super.initState();
    rImage = _random.nextInt(4).toInt();
    setState(() {
      _splash = settingsController.getSplashBackground();
    });

    Wakelock.enable();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  final effectManager = Get.put(EffectManager());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<PrayersController>(builder: (controller) {
      return Scaffold(
        body: Stack(
          children: [
            _splash == "لون ثابت"
                ? const SizedBox()
                : Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppConstant.splashImages[rImage!]),
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
                      initialValue: controller.getDays(),
                      max: controller.getDaysMax(),
                      onTap: () {
                        setState(() {
                          controller.addDay(value: -1);
                        });
                        effectManager.playConfetti(
                            milliseconds: 1000,
                            alignment: Alignment.topCenter,
                            soundType: SoundType.big);
                      },
                      onLongTap: () {
                        setState(() {
                          controller.addDay(value: 1);
                        });
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
                          initialValue: controller.getFajr(),
                          max: controller.getMaxFajr(),
                          onTap: () {
                            setState(() {
                              controller.addPrayer(fajr: -1);
                            });
                            effectManager.playConfetti(
                                milliseconds: 1000,
                                alignment: Alignment.center,
                                soundType: SoundType.small);
                          },
                          size: size.width * .3,
                          tFontSize: 15,
                          vFontSize: 15,
                          onLongTap: () {
                            setState(() {
                              controller.addPrayer(fajr: 1);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CircleIndicator(
                            title: "الظهر",
                            initialValue: controller.getDhuhr(),
                            max: controller.getMaxDhuhr(),
                            onTap: () {
                              setState(() {
                                controller.addPrayer(dhuhr: -1);
                              });
                              effectManager.playConfetti(
                                  milliseconds: 1000,
                                  alignment: Alignment.center,
                                  soundType: SoundType.small);
                            },
                            onLongTap: () {
                              setState(() {
                                controller.addPrayer(dhuhr: 1);
                              });
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
                            initialValue: controller.getAsr(),
                            max: controller.getMaxAsr(),
                            onTap: () {
                              setState(() {
                                controller.addPrayer(asr: -1);
                              });
                              effectManager.playConfetti(
                                  milliseconds: 1000,
                                  alignment: Alignment.center,
                                  soundType: SoundType.small);
                            },
                            onLongTap: () {
                              setState(() {
                                controller.addPrayer(asr: 1);
                              });
                            },
                            size: size.width * .25,
                            tFontSize: 15,
                            vFontSize: 15),
                      ),
                      Expanded(
                        flex: 1,
                        child: CircleIndicator(
                            title: "المغرب",
                            initialValue: controller.getMaghrib(),
                            max: controller.getMaxMaghrib(),
                            onTap: () {
                              setState(() {
                                controller.addPrayer(maghrib: -1);
                              });
                              effectManager.playConfetti(
                                  milliseconds: 1000,
                                  alignment: Alignment.center,
                                  soundType: SoundType.small);
                            },
                            onLongTap: () {
                              setState(() {
                                controller.addPrayer(maghrib: 1);
                              });
                            },
                            size: size.width * .25,
                            tFontSize: 15,
                            vFontSize: 15),
                      ),
                      Expanded(
                        flex: 1,
                        child: CircleIndicator(
                            title: "العشاء",
                            initialValue: controller.getIsha(),
                            max: controller.getMaxIsha(),
                            onTap: () {
                              setState(() {
                                controller.addPrayer(isha: -1);
                              });
                              effectManager.playConfetti(
                                  milliseconds: 1000,
                                  alignment: Alignment.center,
                                  soundType: SoundType.small);
                            },
                            onLongTap: () {
                              setState(() {
                                controller.addPrayer(isha: 1);
                              });
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
                      controller.getEndDateText(),
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
