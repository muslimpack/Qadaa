import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/shared/user_text_field.dart';
import 'package:qadaa/src/features/settings/presentation/controller/settings_controller.dart';

class ChangePrayersCard extends StatelessWidget {
  final SettingsController settingsController;
  const ChangePrayersCard({
    super.key,
    required this.settingsController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              S.of(context).prayers_to_do_per_day,
              textAlign: TextAlign.center,
            ),
            UserTextFieldChanged(
              controller: settingsController.qadaaController,
              hintText: S.of(context).prayers_to_do_per_day,
              onChange: (count) {
                if (count.isNotEmpty) {
                  settingsController.prayersController.setQadaaEveryDay(count);
                  settingsController.update();
                }
              },
            ),
            Text(
              settingsController.prayersController.getPrayerEndDateText(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade200,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
