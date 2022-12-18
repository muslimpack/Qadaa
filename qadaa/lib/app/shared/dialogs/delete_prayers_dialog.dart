import 'package:get/get.dart';
import 'package:qadaa/app/shared/widgets/user_text_field.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';
import 'package:qadaa/core/values/constant.dart';
import 'package:flutter/material.dart';

class DeletePrayersDialog extends StatelessWidget {
  const DeletePrayersDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController fajrController = TextEditingController();
    TextEditingController dhuhrController = TextEditingController();
    TextEditingController asrController = TextEditingController();
    TextEditingController maghribController = TextEditingController();
    TextEditingController ishaController = TextEditingController();
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
                child: Text("قضيت صلوات",
                    style:
                        TextStyle(fontSize: 25, color: AppConstant.mainColor)),
              ),
              const Divider(),
              UserTextField(
                controller: fajrController,
                hintText: "صلوات الفجر",
              ),
              UserTextField(
                controller: dhuhrController,
                hintText: "صلوات الظهر",
              ),
              UserTextField(
                controller: asrController,
                hintText: "صلوات العصر",
              ),
              UserTextField(
                controller: maghribController,
                hintText: "صلوات المغرب",
              ),
              UserTextField(
                controller: ishaController,
                hintText: "صلوات العشاء",
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "تم",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: AppConstant.mainColor),
                ),
                onTap: () {
                  if (fajrController.text.isNotEmpty) {
                    controller.addPrayer(fajr: -int.parse(fajrController.text));
                  }
                  if (dhuhrController.text.isNotEmpty) {
                    controller.addPrayer(
                        dhuhr: -int.parse(dhuhrController.text));
                  }
                  if (asrController.text.isNotEmpty) {
                    controller.addPrayer(asr: -int.parse(asrController.text));
                  }
                  if (maghribController.text.isNotEmpty) {
                    controller.addPrayer(
                        maghrib: -int.parse(maghribController.text));
                  }
                  if (ishaController.text.isNotEmpty) {
                    controller.addPrayer(isha: -int.parse(ishaController.text));
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
