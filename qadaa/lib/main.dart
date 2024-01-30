import 'package:flutter/material.dart';
import 'package:qadaa/app.dart';
import 'package:qadaa/services.dart';

void main() async {
  await initServices();

  runApp(const MyApp());
}
