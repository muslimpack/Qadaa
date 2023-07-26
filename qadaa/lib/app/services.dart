import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:qadaa/app/shared/functions/print.dart';
import 'package:qadaa/core/utils/awesome_notification_manager.dart';

Future<void> initServices() async {
  try {
    //U Doesn't open app notification
    await awesomeNotificationManager.init();
    await awesomeNotificationManager.appOpenNotification();

    //Hive Initialize
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    await Hive.openBox("Prayers");

    // Make Phone StatusBar Transparent
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    /// Keep app in portrait mode and
    /// make it static when phone rotation change
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  } catch (e) {
    qadaaPrint(e.toString());
  }
}
