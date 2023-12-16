// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qadaa/app/shared/widgets/user_text_field.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';
import 'package:qadaa/core/values/constant.dart';
import 'package:qadaa/generated/l10n.dart';

class DeleteDaysDialog extends StatefulWidget {
  final ValueChanged<int> onConfirm;
  final String title;
  const DeleteDaysDialog({
    super.key,
    required this.onConfirm,
    required this.title,
  });

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
                    widget.title,
                    style:
                        TextStyle(fontSize: 25, color: AppConstant.mainColor),
                  ),
                ),
                const Divider(),
                UserTextField(
                  controller: daysController,
                  hintText: S.of(context).days,
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
                    if (daysController.text.isNotEmpty) {
                      widget.onConfirm.call(int.parse(daysController.text));
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
