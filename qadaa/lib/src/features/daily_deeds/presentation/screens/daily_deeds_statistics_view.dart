// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/src/core/shared/loading.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/liquid_circular_progress.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/liquid_linear_progress.dart';
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
                      //  [
                      //   Expanded(
                      //     child: CircularLiquidProgress(
                      //       value: 1,
                      //       child: S.of(context).fajr,
                      //     ),
                      //   ),
                      //   Expanded(
                      //     child: CircularLiquidProgress(
                      //       value: .5,
                      //       child: S.of(context).dhuhr,
                      //     ),
                      //   ),
                      //   Expanded(
                      //     child: CircularLiquidProgress(
                      //       value: .75,
                      //       child: S.of(context).asr,
                      //     ),
                      //   ),
                      //   Expanded(
                      //     child: CircularLiquidProgress(
                      //       value: .8,
                      //       child: S.of(context).maghrib,
                      //     ),
                      //   ),
                      //   Expanded(
                      //     child: CircularLiquidProgress(
                      //       value: .1,
                      //       child: S.of(context).ishaa,
                      //     ),
                      //   ),
                      // ],
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: controller.obligatoryElements
                              .map(
                                (e) => StatsTile(
                                  label: e.label,
                                  count: e.times,
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
                          label: controller.fastElement.label,
                          count: controller.fastElement.times,
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
                                  count: e.times,
                                  value: e.percentage,
                                ),
                              )
                              .toList(),
                          //  [
                          //   StatsTile(
                          //     label: "ركعتا الفجر",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          //   StatsTile(
                          //     label: "الضحى",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          //   StatsTile(
                          //     label: "الظهر القبيله",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          //   StatsTile(
                          //     label: "الظهر البعديه",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          //   StatsTile(
                          //     label: "العصر القبليه",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          //   StatsTile(
                          //     label: "المغرب القبليه",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          //   StatsTile(
                          //     label: "المغرب البعديه",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          //   StatsTile(
                          //     label: "العشاء القبليه",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          //   StatsTile(
                          //     label: "العشاء البعديه",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          //   StatsTile(
                          //     label: "صلاة الليل",
                          //     count: 50,
                          //     value: .5,
                          //   ),
                          // ],
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

class StatsTile extends StatelessWidget {
  final String label;
  final double value;
  final int count;
  const StatsTile({
    super.key,
    required this.label,
    required this.value,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 100),
            child: Text(label),
          ),
          const SizedBox(width: 10),
          Expanded(child: LinearLiquidProgress(value: value)),
          const SizedBox(width: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 50),
            child: Text(
              "$count",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
