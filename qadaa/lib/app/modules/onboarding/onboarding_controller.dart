import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/app/modules/dashboard/app_dashboard.dart';
import 'package:qadaa/app/shared/functions/open_url.dart';
import 'package:qadaa/app/shared/widgets/empty.dart';
import 'package:qadaa/core/values/constant.dart';

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
  //
  final pageList = [
    Empty(
      title: "قضاء الإصدار ${AppConstant.appVersion}",
      description: '''
أهلا بك أيها الموفق في هذا الإصدار الجديد من قضاء 
قم بتقليب الصفحات لرؤية الميزات الجديدة 
''',
    ),
    const Empty(
      isImage: false,
      icon: Icons.palette,
      title: "تحسينات في الواجهة",
    ),
    const Empty(
      isImage: false,
      icon: Icons.bug_report_sharp,
      title: "إصلاح بعض المشاكل",
      description: """
إصلاح بعض المشاكل المتعلقة بالأداء
""",
    ),
    Empty(
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
        )
      },
      buttonText: "افتح متجر بلاي",
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
    final Box box = Hive.box("Prayers");
    box.put("is_${AppConstant.appVersion}_first_open", false);
    Navigator.of(Get.context!).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const AppDashboard();
        },
      ),
    );
  }
}
