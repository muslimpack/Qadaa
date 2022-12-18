// /*
// I get this code from
// Youtube| Flutter: Push Notification (Local, schedule, repeat, daily, weekly)
// URL| https://www.youtube.com/watch?v=KlgVI4dQC4E
//  */

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:io' show Platform;
// import 'package:rxdart/subjects.dart';

// NotificationManager localNotifyManager = NotificationManager.init();

// class NotificationManager {
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   InitializationSettings? initSetting;

//   BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
//       BehaviorSubject<ReceiveNotification>();

//   NotificationManager.init() {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     if (Platform.isIOS) {
//       requestIOSPermission();
//     }
//     initializePlatform();
//   }

//   requestIOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()!
//         .requestPermissions(alert: true, badge: true, sound: true);
//   }

//   initializePlatform() {
//     var initSettingAndroid = const AndroidInitializationSettings('ic_launcher');
//     var initSettingIOS = IOSInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         defaultPresentSound: true,
//         onDidReceiveLocalNotification: (id, title, body, payload) async {
//           ReceiveNotification notification = ReceiveNotification(
//               id: id, title: title!, body: body!, payload: payload!);
//           didReceiveLocalNotificationSubject.add(notification);
//         });

//     initSetting = InitializationSettings(
//         android: initSettingAndroid, iOS: initSettingIOS);
//   }

//   setOnNotificationReceive(Function onNotificationReceive) {
//     didReceiveLocalNotificationSubject.listen((notification) {
//       onNotificationReceive(notification);
//     });
//   }

//   setOnNotificationClick(Function onNotificationClick) async {
//     await flutterLocalNotificationsPlugin.initialize(initSetting!,
//         onSelectNotification: (String? payload) async {
//       onNotificationClick(payload!);
//     });
//   }

//   Future<void> cancelNotificationById({required int id}) async {
//     await flutterLocalNotificationsPlugin.cancel(id);
//   }

//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }

//   Future<void> addCustomDailyReminder(
//       {required String channelName,
//       required int id,
//       required String title,
//       String? body,
//       required Time time,
//       required String payload}) async {
//     var androidChannel = AndroidNotificationDetails(
//       'CHANNEL_ID', channelName,
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       //Add if u need
//       //sound: RawResourceAndroidNotificationSound('notification_sound.mp3'),
//       icon: '@mipmap/ic_launcher',
//       largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//       //timeoutAfter: 5000,
//       enableLights: true,
//     );

//     var iosChannel =
//         const IOSNotificationDetails(/*sound: 'notification_sound.mp3'*/);
//     var platformChannel =
//         NotificationDetails(android: androidChannel, iOS: iosChannel);

//     // ignore: deprecated_member_use
//     await flutterLocalNotificationsPlugin.showDailyAtTime(
//       id,
//       title,
//       body,
//       time,
//       platformChannel,
//       payload: payload,
//     );
//   }

//   Future<void> addCustomWeeklyReminder(
//       {required String channelName,
//       required int id,
//       int showTime = 5000,
//       required String title,
//       String? body,
//       required String payload,
//       required Time time,
//       required Day day}) async {
//     //var time = Time(24, 12, 0);
//     var androidChannel = AndroidNotificationDetails(
//       'CHANNEL_ID',
//       channelName,
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       //Add if u need
//       //sound: RawResourceAndroidNotificationSound('notification_sound.mp3'),
//       icon: '@mipmap/ic_launcher',
//       largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//       //timeoutAfter: showTime,
//       enableLights: true,
//     );

//     var iosChannel =
//         const IOSNotificationDetails(/*sound: 'notification_sound.mp3'*/);
//     var platformChannel =
//         NotificationDetails(android: androidChannel, iOS: iosChannel);

//     //day: Day.Friday
//     //time: Time(24,00,0)
//     // ignore: deprecated_member_use
//     await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//       id,
//       title,
//       body,
//       day,
//       time,
//       platformChannel,
//       payload: payload,
//     );
//   }

//   Future<void> showCustomNotification(
//       {required String title, String? body, required String payload}) async {
//     var androidChannel = const AndroidNotificationDetails(
//       'CHANNEL_ID',
//       'الإشعارات داخل التطبيق',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       //Add if u need
//       //sound: RawResourceAndroidNotificationSound('notification_sound.mp3'),
//       icon: '@mipmap/ic_launcher',
//       largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//       timeoutAfter: 1000,
//       enableLights: true,
//     );

//     var iosChannel =
//         const IOSNotificationDetails(/*sound: 'notification_sound.mp3'*/);
//     var platformChannel =
//         NotificationDetails(android: androidChannel, iOS: iosChannel);

//     await flutterLocalNotificationsPlugin
//         .show(999, title, body, platformChannel, payload: payload);
//   }

//   Future<void> appOpenNotification() async {
//     var scheduleNotificationDateTime =
//         DateTime.now().add(const Duration(days: 3));
//     var androidChannel = const AndroidNotificationDetails(
//       'CHANNEL_ID',
//       'إشعار عدم فتح التطبيق',
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       //Add if u need
//       //sound: RawResourceAndroidNotificationSound('notification_sound.mp3'),
//       icon: '@mipmap/ic_launcher',
//       largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//       enableLights: true,
//     );

//     var iosChannel =
//         const IOSNotificationDetails(/*sound: 'notification_sound.mp3'*/);
//     var platformChannel =
//         NotificationDetails(android: androidChannel, iOS: iosChannel);

//     // ignore: deprecated_member_use
//     await flutterLocalNotificationsPlugin.schedule(
//       1000,
//       'لم تفتح التطبيق منذ فنرة',
//       'إِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَوْقُوتًا',
//       scheduleNotificationDateTime,
//       platformChannel,
//       payload: '2',
//     );
//   }
// }

// class ReceiveNotification {
//   final int id;
//   final String title;
//   final String body;
//   final String payload;

//   ReceiveNotification(
//       {required this.id,
//       required this.title,
//       required this.body,
//       required this.payload});
// }
