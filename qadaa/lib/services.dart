import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/extensions/extension_platform.dart';
import 'package:qadaa/src/core/managers/awesome_notification_manager.dart';
import 'package:qadaa/src/core/managers/storage_repo.dart';
import 'package:qadaa/src/core/utils/print.dart';
import 'package:window_manager/window_manager.dart';

Future<void> initServices() async {
  //Make sure all stuff are initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    //Hive Initializes
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    await Hive.openBox(kAppStorageBoxName);

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

  try {
    await awesomeNotificationManager.init();
    //App open notification
    await awesomeNotificationManager.appOpenNotification();
  } catch (e) {
    qadaaPrint(e);
  }

  if (PlatformExtension.isDesktop) {
    await windowManager.ensureInitialized();
    qadaaPrint(storageRepo.desktopWindowSize);
    final WindowOptions windowOptions = WindowOptions(
      size: storageRepo.desktopWindowSize,
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setResizable(false);
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
