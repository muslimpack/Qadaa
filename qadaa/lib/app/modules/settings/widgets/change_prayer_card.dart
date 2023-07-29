import 'package:flutter/material.dart';
import 'package:qadaa/app/modules/settings/settings_controller.dart';
import 'package:qadaa/app/shared/widgets/user_text_field.dart';

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
            const SizedBox(
              child: Text(
                "عدد صلوات القضاء اليومية",
                textAlign: TextAlign.center,
              ),
            ),
            UserTextFieldChanged(
              controller: settingsController.qadaaController,
              hintText: "عدد صلوات القضاء اليومية ",
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
