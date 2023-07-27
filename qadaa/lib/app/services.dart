import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:qadaa/app/shared/functions/print.dart';
import 'package:qadaa/core/utils/awesome_notification_manager.dart';
import 'package:qadaa/core/utils/storage_repo.dart';

Future<void> initServices() async {
  try {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    //U Doesn't open app notification
    await awesomeNotificationManager.init();
    await awesomeNotificationManager.appOpenNotification();
  } catch (e) {
    qadaaPrint(e);
  }

  try {
    //Hive Initialize
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    await Hive.openBox("Prayers");

    StorageRepo.initialStorage();

    // Make Phone StatusBar Transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    /// Keep app in portrait mode and
    /// make it static when phone rotation change
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  } catch (e) {
    qadaaPrint(e);
  }
}
