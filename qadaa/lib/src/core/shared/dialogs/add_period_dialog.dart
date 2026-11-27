import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/managers/prayer_controller.dart';
import 'package:qadaa/src/core/shared/user_text_field.dart';

class AddPeriodDialog extends StatefulWidget {
  const AddPeriodDialog({super.key});

  @override
  State<AddPeriodDialog> createState() => _AddPeriodDialogState();
}

class _AddPeriodDialogState extends State<AddPeriodDialog> {
  final TextEditingController yearsController = TextEditingController();
  final TextEditingController monthsController = TextEditingController();
  final TextEditingController daysController = TextEditingController();

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
                    S.of(context).custom_add_period,
                    style:
                        TextStyle(fontSize: 25, color: AppConstant.mainColor),
                  ),
                ),
                const Divider(),
                UserTextField(
                  controller: yearsController,
                  hintText: S.of(context).year,
                ),
                UserTextField(
                  controller: monthsController,
                  hintText: S.of(context).month,
                ),
                UserTextField(
                  controller: daysController,
                  hintText: S.of(context).day,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    S.of(context).add,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, color: AppConstant.mainColor),
                  ),
                  onTap: () async {
                    int read(TextEditingController c) =>
                        int.tryParse(c.text) ?? 0;

                    // Add everything in one call: separate un-awaited calls
                    // race on the same Hive keys and only one of them sticks.
                    final int days = read(daysController) +
                        read(monthsController) * 30 +
                        read(yearsController) * 365;
                    if (days > 0) await controller.addDay(value: days);

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
