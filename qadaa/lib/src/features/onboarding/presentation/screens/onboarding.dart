// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/shared/round_button.dart';
import 'package:qadaa/src/features/onboarding/presentation/components/dots.dart';
import 'package:qadaa/src/features/onboarding/presentation/controller/onboarding_controller.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      init: OnBoardingController(),
      builder: (controller) {
        return Scaffold(
          body: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: controller.pageController,
            itemCount: controller.pageList.length,
            itemBuilder: (context, index) {
              return controller.pageList[index];
            },
            onPageChanged: (index) {
              controller.currentPageIndex = index;
              controller.update();
            },
          ),
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Dots(
                      length: controller.pageList.length,
                      activeIndex: controller.currentPageIndex,
                    ),
                  ),
                  if (controller.isFinalPage)
                    RoundButton(
                      radius: 10,
                      text: Text(
                        S.of(context).start,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        controller.goToDashboard();
                      },
                    )
                  else
                    !controller.showSkipBtn
                        ? const SizedBox()
                        : RoundButton(
                            radius: 10,
                            isTransparent: true,
                            text: Text(
                              S.of(context).skip,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              controller.goToDashboard();
                            },
                          ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
