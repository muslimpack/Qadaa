import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/shared/functions/random_notification.dart';
import 'package:qadaa/app/shared/widgets/user_text_field.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';
import 'package:qadaa/core/values/constant.dart';

class DeleteDaysDialog extends StatefulWidget {
  const DeleteDaysDialog({super.key});

  @override
  State<DeleteDaysDialog> createState() => _DeleteDaysDialogState();
}

class _DeleteDaysDialogState extends State<DeleteDaysDialog> {
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
                    "قضيت أياما",
                    style:
                        TextStyle(fontSize: 25, color: AppConstant.mainColor),
                  ),
                ),
                const Divider(),
                UserTextField(
                  controller: daysController,
                  hintText: "عدد الأيام",
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    "تم",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, color: AppConstant.mainColor),
                  ),
                  onTap: () {
                    if (daysController.text.isNotEmpty) {
                      if (controller.getDays() > 0) {
                        controller.addDay(
                          value: -int.parse(daysController.text),
                        );
                        showRandomNotification();
                      }
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
