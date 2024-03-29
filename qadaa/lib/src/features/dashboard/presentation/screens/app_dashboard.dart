import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/managers/effect_manager.dart';
import 'package:qadaa/src/features/dashboard/presentation/components/second_screen_dashboard.dart';
import 'package:qadaa/src/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:qadaa/src/features/splash/presentation/screens/splash_screen.dart';

class AppDashboard extends StatelessWidget {
  const AppDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppDashboardController>(
      init: AppDashboardController(),
      builder: (controller) {
        return controller.isLoading
            ? const SizedBox()
            : Stack(
                children: [
                  Scaffold(
                    body: PageView(
                      physics: const BouncingScrollPhysics(),
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
                    floatingActionButton: FloatingActionButton(
                      mini: true,
                      backgroundColor: AppConstant.mainColor,
                      onPressed: () {
                        controller.currentPageIndex == 0
                            ? controller.goDown()
                            : controller.goUp();
                      },
                      child: Icon(
                        controller.currentPageIndex == 1
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GetBuilder<EffectManager>(
                    init: EffectManager(),
                    builder: (controller) {
                      return Align(
                        alignment: controller.confettiAlignment,
                        child: ConfettiWidget(
                          gravity: controller.gravity,
                          confettiController: controller.confettiController,
                          blastDirectionality: BlastDirectionality.explosive,
                          colors: controller.colors,
                          createParticlePath: controller.drawStar,
                        ),
                      );
                    },
                  ),
                ],
              );
      },
    );
  }
}
