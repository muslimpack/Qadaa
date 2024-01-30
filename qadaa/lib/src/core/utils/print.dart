import 'dart:developer' as developer;

void qadaaPrint(Object? object) {
  printColor(object, color: PrintColors.red);
}

void printColor(Object? object, {int color = 0}) {
  developer.log(
    colorText(object, color: color),
    name: colorText("QADAA", color: color),
  );
}

String colorText(Object? object, {int color = 0}) {
  return '\u001b[${color}m$object\u001b[0m';
}

class PrintColors {
  // Basic Foreground Colors
  static int black = 30;
  static int red = 31;
  static int green = 32;
  static int yellow = 33;
  static int blue = 34;
  static int magenta = 35;
  static int cyan = 36;
  static int white = 37;

  // Bright (Bold) Foreground Colors
  static int brightBlack = 90;
  static int brightRed = 91;
  static int brightGreen = 92;
  static int brightYellow = 93;
  static int brightBlue = 94;
  static int brightMagenta = 95;
  static int brightCyan = 96;
  static int brightWhite = 97;

  // Background Colors
  static int backgroundBlack = 40;
  static int backgroundRed = 41;
  static int backgroundGreen = 42;
  static int backgroundYellow = 43;
  static int backgroundBlue = 44;
  static int backgroundMagenta = 45;
  static int backgroundCyan = 46;
  static int backgroundWhite = 47;

  // Background Bright (Bold) Colors
  static int backgroundBrightBlack = 100;
  static int backgroundBrightRed = 101;
  static int backgroundBrightGreen = 102;
  static int backgroundBrightYellow = 103;
  static int backgroundBrightBlue = 104;
  static int backgroundBrightMagenta = 105;
  static int backgroundBrightCyan = 106;
  static int backgroundBrightWhite = 107;
}

String get fullTimeStamp {
  // Get the current time
  final DateTime now = DateTime.now();

  // Extract hours, minutes, and seconds
  final String hour = now.hour.toString().padLeft(2, "0");
  final String minute = now.minute.toString().padLeft(2, "0");
  final String second = now.second.toString().padLeft(2, "0");
  final String millisecond = now.millisecond.toString().padLeft(3, "0");

  return '$hour:$minute:$second:$millisecond';
}
