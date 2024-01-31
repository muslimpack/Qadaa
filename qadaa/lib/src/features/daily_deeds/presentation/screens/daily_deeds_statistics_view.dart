import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/liquid_circular_progress.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/liquid_linear_progress.dart';

class DailyDeedsStatisticsView extends StatelessWidget {
  const DailyDeedsStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Row(
            children: [
              Expanded(
                child: CircularLiquidProgress(
                  value: 1,
                  child: S.of(context).fajr,
                ),
              ),
              Expanded(
                child: CircularLiquidProgress(
                  value: .5,
                  child: S.of(context).dhuhr,
                ),
              ),
              Expanded(
                child: CircularLiquidProgress(
                  value: .75,
                  child: S.of(context).asr,
                ),
              ),
              Expanded(
                child: CircularLiquidProgress(
                  value: .8,
                  child: S.of(context).maghrib,
                ),
              ),
              Expanded(
                child: CircularLiquidProgress(
                  value: .1,
                  child: S.of(context).ishaa,
                ),
              ),
            ],
          ),
          const Card(
            child: Column(
              children: [
                ListTile(
                  title: Text("ركعتا الفجر"),
                ),
                ListTile(title: Text("الضحى")),
                ListTile(title: Text("الظهر القبيله")),
                ListTile(title: Text("الظهر البعديه")),
                ListTile(title: Text("العصر القبليه")),
                ListTile(title: Text("المغرب القبليه")),
                ListTile(title: Text("المغرب البعديه")),
                ListTile(title: Text("العشاء القبليه")),
                ListTile(title: Text("العشاء البعديه")),
                ListTile(title: Text("صلاة الليل")),
              ],
            ),
          ),
          const LinearLiquidProgress(
            value: .25,
          ),
        ],
      ),
    );
  }
}
