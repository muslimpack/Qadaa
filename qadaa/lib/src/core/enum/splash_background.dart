import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/enum/enum.dart';

enum SplashBackGroundEnum {
  randomImage,
  staticColor,
  staticImage,
}

extension SplashBackGroundExt on SplashBackGroundEnum {
  SplashBackGroundEnum toggle() {
    switch (this) {
      case SplashBackGroundEnum.randomImage:
        return SplashBackGroundEnum.staticColor;
      case SplashBackGroundEnum.staticColor:
        return SplashBackGroundEnum.staticImage;
      case SplashBackGroundEnum.staticImage:
        return SplashBackGroundEnum.randomImage;
    }
  }

  void toText() {
    enumToMap(this);
  }

  String toArabic() {
    switch (this) {
      case SplashBackGroundEnum.randomImage:
        return S.current.splash_random_image;
      case SplashBackGroundEnum.staticColor:
        return S.current.splash_static_color;
      case SplashBackGroundEnum.staticImage:
        return S.current.splash_static_image;
    }
  }
}
