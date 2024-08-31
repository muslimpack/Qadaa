import 'dart:io';

import 'package:flutter/foundation.dart';

extension PlatformExtension on Platform {
  static bool get isDesktop {
    return [
      TargetPlatform.windows,
      TargetPlatform.linux,
      TargetPlatform.macOS,
    ].contains(defaultTargetPlatform);
  }

  static bool get isDesktopOrWeb {
    return isDesktop || kIsWeb;
  }

  static bool get isPhone {
    return Platform.isAndroid || Platform.isIOS;
  }
}
