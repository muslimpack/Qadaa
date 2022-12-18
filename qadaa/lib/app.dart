import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/screens/onboarding.dart';
import 'package:qadaa/shared/constants.dart';
import 'package:qadaa/shared/widgets/loading.dart';
import 'screens/app_dashboard.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : GetMaterialApp(
            locale: const Locale('ar'),
            debugShowCheckedModeBanner: false,
            title: 'فوائت',
            theme: ThemeData.dark(),
            home: () {
              final Box box = Hive.box("Prayers");
              return box.get("is_${appVersion}_first_open", defaultValue: true)
                  ? const OnBoardingPage()
                  : const AppDashboard();
            }(),
          );
  }
}
