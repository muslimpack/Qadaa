import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/shared/widgets/user_text_field.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';
import 'package:qadaa/core/values/constant.dart';
import 'package:qadaa/generated/l10n.dart';

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
                  onTap: () {
                    if (fajrController.text.isNotEmpty) {
                      controller.addPrayer(
                        fajr: -int.parse(fajrController.text),
                      );
                    }
                    if (dhuhrController.text.isNotEmpty) {
                      controller.addPrayer(
                        dhuhr: -int.parse(dhuhrController.text),
                      );
                    }
                    if (asrController.text.isNotEmpty) {
                      controller.addPrayer(asr: -int.parse(asrController.text));
                    }
                    if (maghribController.text.isNotEmpty) {
                      controller.addPrayer(
                        maghrib: -int.parse(maghribController.text),
                      );
                    }
                    if (ishaController.text.isNotEmpty) {
                      controller.addPrayer(
                        isha: -int.parse(ishaController.text),
                      );
                    }

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
