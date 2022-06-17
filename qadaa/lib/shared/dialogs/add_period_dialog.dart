import 'package:get/get.dart';
import 'package:qadaa/controllers/prayer_controller.dart';
import 'package:qadaa/manager/constant.dart';
import 'package:qadaa/shared/widgets/user_text_field.dart';
import 'package:flutter/material.dart';

class AddPeriodDialog extends StatelessWidget {
  const AddPeriodDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController yearsController = TextEditingController();
    TextEditingController monthsController = TextEditingController();
    TextEditingController daysController = TextEditingController();
    return GetBuilder<PrayersController>(builder: (controller) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          margin: const EdgeInsets.all(0.0),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("أضف مدة",
                    style:
                        TextStyle(fontSize: 25, color: AppConstant.mainColor)),
              ),
              const Divider(),
              UserTextField(
                controller: yearsController,
                hintText: "عدد الأعوام",
              ),
              UserTextField(
                controller: monthsController,
                hintText: "عدد الشهور",
              ),
              UserTextField(
                controller: daysController,
                hintText: "عدد الأيام",
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "أضف",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: AppConstant.mainColor),
                ),
                onTap: () {
                  if (daysController.text.isNotEmpty) {
                    controller.addDay(value: int.parse(daysController.text));
                  }

                  if (monthsController.text.isNotEmpty) {
                    controller.addMonth(
                        value: int.parse(monthsController.text));
                  }

                  if (yearsController.text.isNotEmpty) {
                    controller.addYear(value: int.parse(yearsController.text));
                  }

                  Navigator.pop(context, false);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
