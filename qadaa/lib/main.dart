import 'package:flutter/material.dart';
import 'package:qadaa/app/app.dart';
import 'package:qadaa/app/services.dart';

void main() async {
  //Make sure all stuff are initialized
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  runApp(const MyApp());
}
