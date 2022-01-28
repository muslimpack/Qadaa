import 'package:qadaa/manager/prayer_settings.dart';
import 'package:qadaa/shared/dialogs/add_period_dialog.dart';
import 'package:qadaa/shared/dialogs/add_prayers_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qadaa/shared/widgets/tile.dart';

class AddNew extends StatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: false,
        child: ListView(
          children: [
            const SizedBox(height: 10),
            MyTile(
              title: "أضف مدة",
              icon: Icons.add,
              trailing: "",
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return const AddPeriodDialog();
                    }).then((value) {
                  setState(() {});
                });
              },
            ),
            MyTile(
              title: "أضف يومًا",
              icon: Icons.add,
              trailing: prayersSettings.getDays().toInt().toString(),
              onTap: () {
                setState(() {
                  prayersSettings.addDay(value: 1);
                });
              },
            ),
            MyTile(
              title: "أضف أسبوعًا",
              icon: Icons.add,
              trailing: (prayersSettings.getDays() ~/ 7).toString(),
              onTap: () {
                setState(() {
                  prayersSettings.addWeek(value: 1);
                });
              },
            ),
            MyTile(
              title: "أضف شهرًا",
              icon: Icons.add,
              trailing: (prayersSettings.getDays() ~/ 30).toString(),
              onTap: () {
                setState(() {
                  prayersSettings.addMonth(value: 1);
                });
              },
            ),
            MyTile(
              title: "أضف عامًا",
              icon: Icons.add,
              trailing: (prayersSettings.getDays() ~/ 365).toString(),
              onTap: () {
                setState(() {
                  prayersSettings.addYear(value: 1);
                });
              },
            ),

            const Divider(),
            ////

            MyTile(
              title: "أضف صلاة فجر",
              icon: Icons.add,
              trailing: prayersSettings.getFajr().toInt().toString(),
              onTap: () {
                setState(() {
                  prayersSettings.addPrayer(fajr: 1);
                });
              },
            ),
            MyTile(
              title: "أضف صلاة ظهر",
              icon: Icons.add,
              trailing: prayersSettings.getDhuhr().toInt().toString(),
              onTap: () {
                setState(() {
                  prayersSettings.addPrayer(dhuhr: 1);
                });
              },
            ),
            MyTile(
              title: "أضف صلاة عصر",
              icon: Icons.add,
              trailing: prayersSettings.getAsr().toInt().toString(),
              onTap: () {
                setState(() {
                  prayersSettings.addPrayer(asr: 1);
                });
              },
            ),
            MyTile(
              title: "أضف صلاة مغرب",
              icon: Icons.add,
              trailing: prayersSettings.getMaghrib().toInt().toString(),
              onTap: () {
                setState(() {
                  prayersSettings.addPrayer(maghrib: 1);
                });
              },
            ),
            MyTile(
              title: "أضف صلاة عشاء",
              icon: Icons.add,
              trailing: prayersSettings.getIsha().toInt().toString(),
              onTap: () {
                setState(() {
                  prayersSettings.addPrayer(isha: 1);
                });
              },
            ),
            MyTile(
              title: "أضف صلوات",
              icon: Icons.add,
              trailing:
                  (prayersSettings.getAllRemainingPrayer()).toInt().toString(),
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return const AddPrayersDialog();
                    }).then((value) {
                  setState(() {});
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
