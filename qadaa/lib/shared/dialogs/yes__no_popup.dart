import 'package:qadaa/manager/constant.dart';
import 'package:flutter/material.dart';

class YesOrNoDialog extends StatelessWidget {
  final Function onYes;

  const YesOrNoDialog({Key? key, required this.onYes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Text("تنويه",
                  style: TextStyle(fontSize: 25, color: AppConstant.mainColor)),
            ),
            const Divider(),
            const Text(
              "هل أنت متأكد من رغبتك بإعادة ضبط كل شئ؟",
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      "نعم",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, color: AppConstant.mainColor),
                    ),
                    onTap: () {
                      onYes();
                      Navigator.pop<bool>(context, true);
                    },
                  ),
                ),
                Expanded(
                    child: ListTile(
                  title: Text(
                    "لا",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, color: AppConstant.mainColor),
                  ),
                  onTap: () {
                    Navigator.pop<bool>(context, false);
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
