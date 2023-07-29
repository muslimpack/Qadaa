import 'package:qadaa/app/shared/enum/enum.dart';

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
        return "صورة عشوائية";
      case SplashBackGroundEnum.staticColor:
        return "لون ثابت";
      case SplashBackGroundEnum.staticImage:
        return "صورة ثابتة";
    }
  }
}
