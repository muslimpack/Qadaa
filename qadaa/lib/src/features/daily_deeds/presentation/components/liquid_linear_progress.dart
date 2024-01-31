// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:qadaa/src/core/constants/constant.dart';

class CircularLiquidProgress extends StatelessWidget {
  final double value;
  final String? child;
  const CircularLiquidProgress({
    super.key,
    required this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: LiquidCircularProgressIndicator(
          value: value,
          valueColor: AlwaysStoppedAnimation(
            AppConstant.mainColor,
          ),
          // backgroundColor: Colors.grey[800],
          borderColor: AppConstant.mainColor,
          borderWidth: 2,
          center: Text(
            child ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              // color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
