import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'controllers/app_controller.dart';
import 'controllers/effect_manager.dart';
import 'manager/notification_manager.dart';
import 'screens/app_dashboard.dart';

void main() async {
  //Make sure all stuff are initialized
  WidgetsFlutterBinding.ensureInitialized();

  //U Doesn't open app notification
  localNotifyManager.appOpenNotification();

  //Hive Initialize
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  // Make Phone StatusBar Transparent
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);

  /// Keep app in portrait mode and
  /// make it static when phone rotation change
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        init: AppController(),
        builder: (context) {
          return GetMaterialApp(
            locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
            title: 'فوائت',
            theme: ThemeData.dark(),
            home: FutureBuilder(
              future: Hive.openBox("Prayers"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return GetBuilder<EffectManager>(
                        init: EffectManager(),
                        builder: (controller) {
                          return Stack(
                            children: [
                              const AppDashboard(),
                              Align(
                                alignment: controller.confettiAlignment,
                                child: ConfettiWidget(
                                  confettiController:
                                      controller.confettiController,
                                  blastDirectionality:
                                      BlastDirectionality.explosive,
                                  shouldLoop: false,
                                  colors: controller.colors,
                                  createParticlePath: controller.drawStar,
                                ),
                              ),
                            ],
                          );
                        });
                  }
                } else {
                  return const Scaffold();
                }
              },
            ),
          );
        });
  }
}
