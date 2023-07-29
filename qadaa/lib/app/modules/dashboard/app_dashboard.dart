import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/modules/dashboard/dashboard_controller.dart';
import 'package:qadaa/app/modules/dashboard/second_screen_dashboard.dart';
import 'package:qadaa/app/modules/splash/splash_screen.dart';
import 'package:qadaa/app/shared/widgets/scroll_glow_remover.dart';
import 'package:qadaa/core/utils/effect_manager.dart';
import 'package:qadaa/core/values/constant.dart';

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
                  ScrollGlowRemover(
                    child: Scaffold(
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
                      floatingActionButton: FloatingActionButton(
                        mini: true,
                        backgroundColor: AppConstant.mainColor,
                        onPressed: () {
                          controller.currentPageIndex == 0
                              ? controller.goDown()
                              : controller.goUp();
                        },
                        tooltip: 'Increment',
                        child: Icon(
                          controller.currentPageIndex == 1
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: Colors.white,
                        ),
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
