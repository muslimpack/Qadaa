// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:qadaa/src/core/constants/constant.dart';

class LinearLiquidProgress extends StatelessWidget {
  final double value;
  final String? child;
  const LinearLiquidProgress({
    super.key,
    required this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 5,
      padding: const EdgeInsets.all(10),
      child: LiquidLinearProgressIndicator(
        value: value,
        valueColor: AlwaysStoppedAnimation(
          AppConstant.mainColor,
        ),
        // backgroundColor: Colors.grey[800],
        borderColor: AppConstant.mainColor,
        direction: Axis.vertical,
        borderWidth: 2,
        center: Text(
          child ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            // color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
