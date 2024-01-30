import 'package:flutter/material.dart';
import 'package:qadaa/app/shared/enum/sound_type.dart';
import 'package:qadaa/app/shared/widgets/custom_sleek.dart';
import 'package:qadaa/src/features/splash/presentation/controller/splash_controller.dart';

class SinglePrayCircleIndicator extends StatelessWidget {
  final Size size;
  final double sizeFactor;
  final String title;
  final int initialValue;
  final int max;
  final Function() onTap;
  final Function() onLongTap;
  final SplashController controller;
  const SinglePrayCircleIndicator({
    super.key,
    required this.size,
    this.sizeFactor = .3,
    required this.title,
    required this.initialValue,
    required this.max,
    required this.onTap,
    required this.onLongTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CircleIndicator(
        title: title,
        initialValue: initialValue,
        max: max,
        onTap: () async {
          onTap();

          await controller.effectManager.playConfetti(
            alignment: Alignment.center,
            soundType: SoundType.small,
          );
          controller.update();
        },
        size: size.width * .3,
        tFontSize: 15,
        vFontSize: 15,
        onLongTap: () {
          onLongTap();
          controller.update();
        },
      ),
    );
  }
}
