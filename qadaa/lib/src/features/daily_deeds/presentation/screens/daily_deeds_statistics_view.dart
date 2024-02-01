// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/src/core/shared/loading.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/liquid_linear_progress.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/stats_tile.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/controller/daily_deeds_stats_controller.dart';

class DailyDeedsStatisticsView extends StatelessWidget {
  const DailyDeedsStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DailyDeedsStatisticsController(),
      builder: (controller) {
        return controller.isLoading
            ? const Loading()
            : Scaffold(
                body: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    Row(
                      children: controller.obligatoryElements
                          .map(
                            (e) => Expanded(
                              child: CircularLiquidProgress(
                                value: e.percentage,
                                child: e.label,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: controller.obligatoryElements
                              .map(
                                (e) => StatsTile(
                                  label: e.label,
                                  times: e.times,
                                  value: e.percentage,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: StatsTile(
                          label: controller.fastingElement.label,
                          times: controller.fastingElement.times,
                          value: 1,
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: controller.additionalElements
                              .map(
                                (e) => StatsTile(
                                  label: e.label,
                                  times: e.times,
                                  value: e.percentage,
                                  count: e.count,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
