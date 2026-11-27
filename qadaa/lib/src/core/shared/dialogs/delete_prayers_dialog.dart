import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/managers/prayer_controller.dart';
import 'package:qadaa/src/core/shared/user_text_field.dart';

class DeletePrayersDialog extends StatefulWidget {
  const DeletePrayersDialog({super.key});

  @override
  State<DeletePrayersDialog> createState() => _DeletePrayersDialogState();
}

class _DeletePrayersDialogState extends State<DeletePrayersDialog> {
  final TextEditingController fajrController = TextEditingController();
  final TextEditingController dhuhrController = TextEditingController();
  final TextEditingController asrController = TextEditingController();
  final TextEditingController maghribController = TextEditingController();
  final TextEditingController ishaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayersController>(
      builder: (controller) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            margin: EdgeInsets.zero,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    S.of(context).make_up_missed_prayers,
                    style:
                        TextStyle(fontSize: 25, color: AppConstant.mainColor),
                  ),
                ),
                const Divider(),
                UserTextField(
                  controller: fajrController,
                  hintText: S.of(context).fajr,
                ),
                UserTextField(
                  controller: dhuhrController,
                  hintText: S.of(context).dhuhr,
                ),
                UserTextField(
                  controller: asrController,
                  hintText: S.of(context).asr,
                ),
                UserTextField(
                  controller: maghribController,
                  hintText: S.of(context).maghrib,
                ),
                UserTextField(
                  controller: ishaController,
                  hintText: S.of(context).ishaa,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    S.of(context).done,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, color: AppConstant.mainColor),
                  ),
                  onTap: () async {
                    int read(TextEditingController c) =>
                        int.tryParse(c.text) ?? 0;

                    // One call: separate un-awaited calls race on the same
                    // Hive keys and can overwrite each other.
                    await controller.addPrayer(
                      fajr: -read(fajrController),
                      dhuhr: -read(dhuhrController),
                      asr: -read(asrController),
                      maghrib: -read(maghribController),
                      isha: -read(ishaController),
                    );

                    if (!context.mounted) return;
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
