// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';

class DailyDeedsStatisticsView extends StatelessWidget {
  const DailyDeedsStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: LiquidProgress(
                  value: .25,
                  child: S.of(context).fajr,
                ),
              ),
              const Expanded(
                child: LiquidProgress(value: .25),
              ),
            ],
          ),
          const Row(
            children: [
              Expanded(
                child: LiquidProgress(value: .25),
              ),
              Expanded(
                child: LiquidProgress(value: .25),
              ),
              Expanded(
                child: LiquidProgress(value: .25),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LiquidProgress extends StatelessWidget {
  final double value;
  final String? child;
  const LiquidProgress({
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
          borderWidth: 0.0,
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
