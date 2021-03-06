import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:qadaa/screens/app_dashboard.dart';
import 'package:qadaa/shared/widgets/bouncy_page.dart';
import '../shared/widgets/empty.dart';

class OnBoardingController extends GetxController {
  /* *************** Variables *************** */
  //
  PageController pageController = PageController(initialPage: 0);
  //
  bool get isFinalPage => currentPageIndex + 1 == pageList.length;
  //TODO show skip button
  bool get showSkipBtn => false;
  //
  int currentPageIndex = 0;
  //
  static const _volumeBtnChannel = MethodChannel("volume_button_channel");
  //
  final pageList = [
    const Empty(
      title: "قضاء الإصدار 1.1.0",
      description: '''
أهلا بك أيها الموفق في هذا الإصدار الجديد من قضاء 
قم بتقليب الصفحات لرؤية الميزات الجديدة 
''',
    ),
    const Empty(
      isImage: false,
      icon: Icons.lock,
      title: "إضافة قفل للتطبيق",
      description: """
يمكنك الآن إضافة قفل للتطبيق لمنع الأطفال من الولوج إلى التطبيق والعبث في إعداداتك
""",
    ),
    const Empty(
      isImage: false,
      icon: Icons.speaker,
      title: "إضافة  مؤثرات صوتية",
      description: """
مؤثرات صوتية عند اتمام صلاة أو يوم
""",
    ),
    const Empty(
      isImage: false,
      icon: Icons.fire_hydrant,
      title: "إضافة مؤثرات بصرية",
      description: """
مؤثرات بصرية عند اتمام صلاة أو يوم
""",
    ),
    const Empty(
      isImage: false,
      icon: Icons.bug_report_sharp,
      title: "إصلاح بعض المشاكل",
      description: """
إصلاح بعض المشاكل المتعلقة بالأداء
""",
    ),
  ];

  /* *************** Controller life cycle *************** */
  //
  @override
  void onInit() async {
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

      return Future.value(null);
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
  /// and set app fisrt open to false
  goToDashboard() {
    final Box box = Hive.box("Prayers");
    box.put("is_v1.1_first_open", false);
    transitionAnimation.fromBottom2Top(
        context: Get.context!, goToPage: const AppDashboard());
  }
}
