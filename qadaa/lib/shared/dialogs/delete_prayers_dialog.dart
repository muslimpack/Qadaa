import 'package:qadaa/manager/constant.dart';
import 'package:qadaa/manager/prayer_settings.dart';
import 'package:qadaa/shared/widgets/user_text_field.dart';
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
                  style: TextStyle(fontSize: 25, color: AppConstant.mainColor)),
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
                  prayersSettings.addPrayer(
                      fajr: -int.parse(fajrController.text));
                }
                if (dhuhrController.text.isNotEmpty) {
                  prayersSettings.addPrayer(
                      dhuhr: -int.parse(dhuhrController.text));
                }
                if (asrController.text.isNotEmpty) {
                  prayersSettings.addPrayer(
                      asr: -int.parse(asrController.text));
                }
                if (maghribController.text.isNotEmpty) {
                  prayersSettings.addPrayer(
                      maghrib: -int.parse(maghribController.text));
                }
                if (ishaController.text.isNotEmpty) {
                  prayersSettings.addPrayer(
                      isha: -int.parse(ishaController.text));
                }

                Navigator.pop(context, false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
