import 'package:flutter/foundation.dart';

void qadaaPrint(Object? object) {
  if (kDebugMode) {
    print(stylizeText(text: "[Qadaa] ${object!}"));
  }
}

String? stylizeText({required String? text}) {
  return "\x1B[32m${text!}";
}
