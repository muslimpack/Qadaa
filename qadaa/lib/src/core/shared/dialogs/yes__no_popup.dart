import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';

class YesOrNoDialog extends StatelessWidget {
  final Function() onYes;

  const YesOrNoDialog({super.key, required this.onYes});

  @override
  Widget build(BuildContext context) {
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
                S.of(context).alert,
                style: TextStyle(fontSize: 25, color: AppConstant.mainColor),
              ),
            ),
            const Divider(),
            Text(
              S.of(context).sure_to_reset_everything_msg,
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(
                      S.of(context).yes,
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
                      S.of(context).no,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, color: AppConstant.mainColor),
                    ),
                    onTap: () {
                      Navigator.pop<bool>(context, false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
