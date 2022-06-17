import 'package:get/get.dart';
import 'package:qadaa/controllers/dashboard_controller.dart';
import 'package:qadaa/manager/constant.dart';
import 'package:qadaa/pages/second_screen_dashboard.dart';
import 'package:qadaa/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class AppDashboard extends StatelessWidget {
  const AppDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppDashboardController>(
        init: AppDashboardController(),
        builder: (controller) {
          return controller.isLoading
              ? const SizedBox()
              : Scaffold(
                  body: ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: AppConstant.scrollColor,
                      child: PageView(
                        physics: const ClampingScrollPhysics(),
                        controller: controller.pageController,
                        scrollDirection: Axis.vertical,
                        children: const [
                          SplashScreen(),
                          SecondScreenDashboard(),
                        ],
                        onPageChanged: (value) {
                          controller.currentPageIndex = value;
                        },
                      ),
                    ),
                  ),
                  floatingActionButton: controller.currentPageIndex == 0
                      ? null
                      : FloatingActionButton(
                          mini: true,
                          backgroundColor: AppConstant.mainColor,
                          onPressed: () {
                            controller.pageController.animateTo(0.0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.linear);
                            // _controller.jumpToPage(0);
                          },
                          tooltip: 'Increment',
                          child: const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ),
                );
        });
  }
}
