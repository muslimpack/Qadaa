import 'dart:math';

import 'package:flutter/material.dart';

class ColorGenerator {
  static Color highContrastByKey({
    required String key,
  }) {
    final int seed = (key).hashCode;
    final random = Random(seed);
    int red;
    int green;
    int blue;
    while (true) {
      red = random.nextInt(256);
      green = random.nextInt(256);
      blue = random.nextInt(256);
      if (red + green + blue > 380 && red + green + blue < 760) {
        return Color.fromRGBO(red, green, blue, 1);
      }
    }
  }
}
