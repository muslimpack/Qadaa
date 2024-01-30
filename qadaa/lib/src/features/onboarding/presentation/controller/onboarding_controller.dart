import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/managers/storage_repo.dart';
import 'package:qadaa/src/core/utils/open_url.dart';
import 'package:qadaa/src/features/dashboard/presentation/screens/app_dashboard.dart';
import 'package:qadaa/src/features/onboarding/presentation/components/onboarding_item.dart';

class OnBoardingController extends GetxController {
  /* *************** Variables *************** */
  //
  PageController pageController = PageController();
  //
  bool get isFinalPage => currentPageIndex + 1 == pageList.length;
  bool get showSkipBtn => false;
  //
  int currentPageIndex = 0;
  //
  static const _volumeBtnChannel = MethodChannel("volume_button_channel");
  //TODO edit every release
  final pageList = [
    OnboardingItem(
      title: "${S.current.qadaa} ${AppConstant.appVersion}",
      description: '''
أهلا بك أيها الموفق في هذا الإصدار الجديد من قضاء 
قم بتقليب الصفحات لرؤية الميزات الجديدة 
''',
    ),
    OnboardingItem(
      isImage: false,
      icon: Icons.translate,
      title: S.current.app_lang,
    ),
    OnboardingItem(
      imagePath: "assets/images/rukia.png",
      title: "تطبيق رقية",
      description: """
الرقية الشرعية من القرآن الكريم والسنة النبوية للدكتور خالد بن عبدالرحمن الجريسي

محتويات التطبيق
-آداب وإرشادات عامة تراعى عند الرقية
-الرقية المختصرة  -الرقية المتوسطة  -الرقية المطولة

- من إصداراتنا -
""",
      onButtonCLick: () => {
        openURL(
          "https://play.google.com/store/apps/details?id=com.hassaneltantawy.ruqayyah",
        ),
      },
      buttonText: S.current.open_in_google_play,
    ),
  ];

  /* *************** Controller life cycle *************** */
  //
  @override
  Future<void> onInit() async {
    super.onInit();
    //
    _volumeBtnChannel.setMethodCallHandler((call) {
      if (call.method == "volumeBtnPressed") {
        if (call.arguments == "VOLUME_DOWN_UP") {
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
        if (call.arguments == "VOLUME_UP_UP") {
          pageController.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      }

      return Future.value();
    });
  }

  @override
  void onClose() {
    super.onClose();
    //
    pageController.dispose();

    ///
    _volumeBtnChannel.setMethodCallHandler(null);
  }

  /* *************** Functions *************** */
  /// Go to dashboard
  /// and set app first open to false
  void goToDashboard() {
    storageRepo.setFirstOpen(false);

    Navigator.of(Get.context!).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const AppDashboard();
        },
      ),
    );
  }
}
