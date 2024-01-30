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
                  onTap: () {
                    if (daysController.text.isNotEmpty) {
                      controller.addDay(value: int.parse(daysController.text));
                    }

                    if (monthsController.text.isNotEmpty) {
                      controller.addMonth(
                        value: int.parse(monthsController.text),
                      );
                    }

                    if (yearsController.text.isNotEmpty) {
                      controller.addYear(
                        value: int.parse(yearsController.text),
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
