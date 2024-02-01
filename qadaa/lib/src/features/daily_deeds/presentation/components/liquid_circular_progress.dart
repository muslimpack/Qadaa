// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
    return LinearProgressIndicator(
      minHeight: 10,
      value: value,
      valueColor: AlwaysStoppedAnimation(
        AppConstant.mainColor,
      ),
    );
  }
}
