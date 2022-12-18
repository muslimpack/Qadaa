import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qadaa/app.dart';
import 'package:qadaa/services.dart';

void main() async {
  //Make sure all stuff are initialized
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  // Make Phone StatusBar Transparent
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  /// Keep app in portrait mode and
  /// make it static when phone rotation change
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}
