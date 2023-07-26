import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/app/modules/onboarding/onboarding.dart';
import 'package:qadaa/app/shared/functions/print.dart';
import 'package:qadaa/app/shared/widgets/loading.dart';
import 'package:qadaa/core/values/constant.dart';
import 'modules/dashboard/app_dashboard.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  bool isFirstOpen = false;
  @override
  void initState() {
    super.initState();
    checkIfFirstOpen();
    setState(() {
      isLoading = false;
    });
  }

  void checkIfFirstOpen() {
    try {
      final Box box = Hive.box("Prayers");
      isFirstOpen = box.get(
        "is_${AppConstant.appVersion}_first_open",
        defaultValue: true,
      );
    } catch (e) {
      qadaaPrint(e);
    }
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
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorSchemeSeed: Colors.pink,
              fontFamily: "Cairo",
            ),
            home: () {
              return isFirstOpen
                  ? const OnBoardingPage()
                  : const AppDashboard();
            }(),
          );
  }
}
