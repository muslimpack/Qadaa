import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/shared/dialogs/add_period_dialog.dart';
import 'package:qadaa/app/shared/dialogs/add_prayers_dialog.dart';
import 'package:qadaa/app/shared/widgets/tile.dart';
import 'package:qadaa/core/utils/prayer_controller.dart';

class AddNew extends StatelessWidget {
  const AddNew({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayersController>(
      builder: (controller) {
        return Scaffold(
          body: Scrollbar(
            thumbVisibility: false,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 70).copyWith(
                left: 10,
                right: 10,
              ),
              children: [
                const SizedBox(height: 10),
                MyTile(
                  title: "أضف مدة",
                  icon: Icons.add,
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return const AddPeriodDialog();
                      },
                    ).then((value) {});
                  },
                ),
                MyTile(
                  title: "أضف يومًا",
                  icon: Icons.add,
                  trailing: controller.getDays().toString(),
                  onTap: () {
                    controller.addDay(value: 1);
                  },
                ),
                MyTile(
                  title: "أضف أسبوعًا",
                  icon: Icons.add,
                  trailing: (controller.getDays() ~/ 7).toString(),
                  onTap: () {
                    controller.addWeek(value: 1);
                  },
                ),
                MyTile(
                  title: "أضف شهرًا",
                  icon: Icons.add,
                  trailing: (controller.getDays() ~/ 30).toString(),
                  onTap: () {
                    controller.addMonth(value: 1);
                  },
                ),
                MyTile(
                  title: "أضف عامًا",
                  icon: Icons.add,
                  trailing: (controller.getDays() ~/ 365).toString(),
                  onTap: () {
                    controller.addYear(value: 1);
                  },
                ),

                const Divider(),
                ////

                MyTile(
                  title: "أضف صلاة فجر",
                  icon: Icons.add,
                  trailing: controller.getFajr().toString(),
                  onTap: () {
                    controller.addPrayer(fajr: 1);
                  },
                ),
                MyTile(
                  title: "أضف صلاة ظهر",
                  icon: Icons.add,
                  trailing: controller.getDhuhr().toString(),
                  onTap: () {
                    controller.addPrayer(dhuhr: 1);
                  },
                ),
                MyTile(
                  title: "أضف صلاة عصر",
                  icon: Icons.add,
                  trailing: controller.getAsr().toString(),
                  onTap: () {
                    controller.addPrayer(asr: 1);
                  },
                ),
                MyTile(
                  title: "أضف صلاة مغرب",
                  icon: Icons.add,
                  trailing: controller.getMaghrib().toString(),
                  onTap: () {
                    controller.addPrayer(maghrib: 1);
                  },
                ),
                MyTile(
                  title: "أضف صلاة عشاء",
                  icon: Icons.add,
                  trailing: controller.getIsha().toString(),
                  onTap: () {
                    controller.addPrayer(isha: 1);
                  },
                ),
                MyTile(
                  title: "أضف صلوات",
                  icon: Icons.add,
                  trailing: controller.getAllRemainingPrayer().toString(),
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return const AddPrayersDialog();
                      },
                    ).then((value) {});
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
