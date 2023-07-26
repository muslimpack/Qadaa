import 'package:flutter/material.dart';
import 'package:qadaa/core/values/constant.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircleIndicator extends StatelessWidget {
  final String title;
  final double tFontSize;
  final double vFontSize;
  final double size;
  final int initialValue;
  final int max;
  final Function() onTap;
  final Function() onLongTap;

  const CircleIndicator({
    super.key,
    required this.title,
    required this.initialValue,
    required this.max,
    required this.size,
    required this.tFontSize,
    required this.vFontSize,
    required this.onTap,
    required this.onLongTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => onLongTap(),
      onTap: () => onTap(),
      child: SleekCircularSlider(
        max: max.toDouble(),
        initialValue: initialValue.toDouble(),
        appearance: CircularSliderAppearance(
          startAngle: 180,
          angleRange: 180,
          infoProperties: InfoProperties(
            bottomLabelText: title,
            bottomLabelStyle: TextStyle(
              fontSize: tFontSize,
            ),
            mainLabelStyle: TextStyle(
              fontSize: vFontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            modifier: (double value) {
              final circval = value.ceil().toString();
              return circval;
            },
          ),
          customColors: CustomSliderColors(
            trackColor: Colors.blue.shade100,
            // shadowColor: Colors.orange,
            progressBarColors: [
              AppConstant.mainColor,
              Colors.blue[400]!,
              //  Colors.orange
            ],
          ),
          size: size,
        ),
      ),
    );
  }
}
