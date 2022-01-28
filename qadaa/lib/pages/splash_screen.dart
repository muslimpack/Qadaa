import 'dart:math';
import 'dart:ui';
import 'package:qadaa/manager/constant.dart';
import 'package:qadaa/manager/prayer_settings.dart';
import 'package:qadaa/manager/settings_manager.dart';
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
  @override
  void initState() {
    super.initState();
    rImage = _random.nextInt(4).toInt();
    setState(() {
      _splash = settingsManager.getSplashBackground();
    });

    Wakelock.enable();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    initialValue: prayersSettings.getDays(),
                    max: prayersSettings.getDaysMax(),
                    onTap: () {
                      setState(() {
                        prayersSettings.addDay(value: -1);
                      });
                    },
                    onLongTap: () {
                      setState(() {
                        prayersSettings.addDay(value: 1);
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
                        initialValue: prayersSettings.getFajr(),
                        max: prayersSettings.getMaxFajr(),
                        onTap: () {
                          setState(() {
                            prayersSettings.addPrayer(fajr: -1);
                          });
                        },
                        size: size.width * .3,
                        tFontSize: 15,
                        vFontSize: 15,
                        onLongTap: () {
                          setState(() {
                            prayersSettings.addPrayer(fajr: 1);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CircleIndicator(
                          title: "الظهر",
                          initialValue: prayersSettings.getDhuhr(),
                          max: prayersSettings.getMaxDhuhr(),
                          onTap: () {
                            setState(() {
                              prayersSettings.addPrayer(dhuhr: -1);
                            });
                          },
                          onLongTap: () {
                            setState(() {
                              prayersSettings.addPrayer(dhuhr: 1);
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
                          initialValue: prayersSettings.getAsr(),
                          max: prayersSettings.getMaxAsr(),
                          onTap: () {
                            setState(() {
                              prayersSettings.addPrayer(asr: -1);
                            });
                          },
                          onLongTap: () {
                            setState(() {
                              prayersSettings.addPrayer(asr: 1);
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
                          initialValue: prayersSettings.getMaghrib(),
                          max: prayersSettings.getMaxMaghrib(),
                          onTap: () {
                            setState(() {
                              prayersSettings.addPrayer(maghrib: -1);
                            });
                          },
                          onLongTap: () {
                            setState(() {
                              prayersSettings.addPrayer(maghrib: 1);
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
                          initialValue: prayersSettings.getIsha(),
                          max: prayersSettings.getMaxIsha(),
                          onTap: () {
                            setState(() {
                              prayersSettings.addPrayer(isha: -1);
                            });
                          },
                          onLongTap: () {
                            setState(() {
                              prayersSettings.addPrayer(isha: 1);
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
                    prayersSettings.getEndDateText(),
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
  }
}
