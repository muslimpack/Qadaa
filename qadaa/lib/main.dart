import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:qadaa/screens/onboarding.dart';
import 'manager/notification_manager.dart';
import 'screens/app_dashboard.dart';

void main() async {
  //Make sure all stuff are initialized
  WidgetsFlutterBinding.ensureInitialized();

  //U Doesn't open app notification
  await localNotifyManager.appOpenNotification();

  //Hive Initialize
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  // Make Phone StatusBar Transparent
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);

  /// Keep app in portrait mode and
  /// make it static when phone rotation change
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    //Close All Boxes
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              //TODO remove next release
              final Box box = Hive.box("Prayers");
              return box.get("is_v1.1_first_open", defaultValue: true)
                  ? const OnBoardingPage()
                  : const AppDashboard();
              // return  AppDashboard();
            }
          } else {
            return const Scaffold();
          }
        },
      ),
    );
  }
}
