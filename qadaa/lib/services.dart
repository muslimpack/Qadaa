import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:qadaa/manager/awesome_notification_manager.dart';
import 'package:qadaa/shared/functions/print.dart';

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
  } catch (e) {
    qadaaPrint(e.toString());
  }
}
