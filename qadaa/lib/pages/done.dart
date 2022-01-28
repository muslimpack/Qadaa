import 'package:qadaa/Shared/Widgets/Tile.dart';
import 'package:qadaa/manager/prayer_settings.dart';
import 'package:qadaa/shared/dialogs/delete_days_dialog.dart';
import 'package:qadaa/shared/dialogs/delete_prayers_dialog.dart';
import 'package:qadaa/shared/functions/random_notification.dart';
import 'package:flutter/material.dart';

class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);

  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      isAlwaysShown: false,
      child: ListView(
        children: [
          const SizedBox(height: 10),
          MyTile(
            title: "قضيت يومًا",
            icon: Icons.done,
            trailing: prayersSettings.getDays().toInt().toString(),
            onTap: () {
              setState(() {
                if (prayersSettings.getDays() > 0) {
                  prayersSettings.addDay(value: -1);
                  showRandomNotification();
                }
              });
            },
          ),
          MyTile(
            title: "قضيت أيامًا",
            icon: Icons.done,
            trailing: prayersSettings.getDays().toInt().toString(),
            onTap: () {
              setState(() {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return const DeleteDaysDialog();
                    }).then((value) {
                  setState(() {});
                });
              });
            },
          ),
          const Divider(),
          MyTile(
            title: "قضيت صلاة فجر",
            icon: Icons.done,
            trailing: prayersSettings.getFajr().toInt().toString(),
            onTap: () {
              setState(() {
                prayersSettings.addPrayer(fajr: -1);
              });
            },
          ),
          MyTile(
            title: "قضيت صلاة ظهر",
            icon: Icons.done,
            trailing: prayersSettings.getDhuhr().toInt().toString(),
            onTap: () {
              setState(() {
                prayersSettings.addPrayer(dhuhr: -1);
              });
            },
          ),
          MyTile(
            title: "قضيت صلاة عصر",
            icon: Icons.done,
            trailing: prayersSettings.getAsr().toInt().toString(),
            onTap: () {
              setState(() {
                prayersSettings.addPrayer(asr: -1);
              });
            },
          ),
          MyTile(
            title: "قضيت صلاة مغرب",
            icon: Icons.done,
            trailing: prayersSettings.getMaghrib().toInt().toString(),
            onTap: () {
              setState(() {
                prayersSettings.addPrayer(maghrib: -1);
              });
            },
          ),
          MyTile(
            title: "قضيت صلاة عشاء",
            icon: Icons.done,
            trailing: prayersSettings.getIsha().toInt().toString(),
            onTap: () {
              setState(() {
                prayersSettings.addPrayer(isha: -1);
              });
            },
          ),
          MyTile(
            title: "قضيت صلوات",
            icon: Icons.done,
            trailing:
                (prayersSettings.getAllRemainingPrayer()).toInt().toString(),
            onTap: () {
              setState(() {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return const DeletePrayersDialog();
                    }).then((value) {
                  setState(() {});
                });
              });
            },
          ),
        ],
      ),
    ));
  }
}
