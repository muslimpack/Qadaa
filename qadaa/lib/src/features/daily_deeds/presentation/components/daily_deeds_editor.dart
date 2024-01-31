// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/components/count_selector.dart';

class DailyDeedsEditor extends StatefulWidget {
  final DailyDeeds dailyDeeds;
  const DailyDeedsEditor({
    super.key,
    required this.dailyDeeds,
  });

  @override
  State<DailyDeedsEditor> createState() => _DailyDeedsEditorState();
}

class _DailyDeedsEditorState extends State<DailyDeedsEditor> {
  late DailyDeeds dailyDeeds;
  @override
  void initState() {
    dailyDeeds = widget.dailyDeeds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 450),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              title: const Text("أعمال اليوم"),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: TabBar(
                  physics: const BouncingScrollPhysics(),
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  indicatorColor: AppConstant.mainColor,
                  labelColor: AppConstant.mainColor,
                  unselectedLabelColor: Colors.white,
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: const <Widget>[
                    Tab(
                      text: "عام",
                    ),
                    Tab(
                      text: "الفروض",
                    ),
                    Tab(
                      text: "النوافل",
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ListTile(
                            title: Text(
                              DateFormat('E dd / MM / yyyy')
                                  .format(dailyDeeds.date),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SwitchListTile(
                            value: dailyDeeds.fasting,
                            title: Text(S.of(context).fast),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds =
                                    dailyDeeds.copyWith(fasting: value);
                              });
                            },
                          ),
                        ],
                      ),

                      /// obligatoryPrayers
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SwitchListTile(
                            value: dailyDeeds.obligatoryPrayers.fajr,
                            title: Text(S.of(context).fajr),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  obligatoryPrayers: dailyDeeds
                                      .obligatoryPrayers
                                      .copyWith(fajr: value),
                                );
                              });
                            },
                          ),
                          SwitchListTile(
                            value: dailyDeeds.obligatoryPrayers.dhuhr,
                            title: Text(S.of(context).dhuhr),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  obligatoryPrayers: dailyDeeds
                                      .obligatoryPrayers
                                      .copyWith(dhuhr: value),
                                );
                              });
                            },
                          ),
                          SwitchListTile(
                            value: dailyDeeds.obligatoryPrayers.asr,
                            title: Text(S.of(context).asr),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  obligatoryPrayers: dailyDeeds
                                      .obligatoryPrayers
                                      .copyWith(asr: value),
                                );
                              });
                            },
                          ),
                          SwitchListTile(
                            value: dailyDeeds.obligatoryPrayers.maghrib,
                            title: Text(S.of(context).maghrib),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  obligatoryPrayers: dailyDeeds
                                      .obligatoryPrayers
                                      .copyWith(maghrib: value),
                                );
                              });
                            },
                          ),
                          SwitchListTile(
                            value: dailyDeeds.obligatoryPrayers.ishaa,
                            title: Text(S.of(context).ishaa),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  obligatoryPrayers: dailyDeeds
                                      .obligatoryPrayers
                                      .copyWith(ishaa: value),
                                );
                              });
                            },
                          ),
                        ],
                      ),

                      /// obligatoryPrayers
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          PrayerCountSelector(
                            numbers: const [0, 2],
                            value: dailyDeeds.additionalPrayers.fajrPre,
                            title: const Text("ركعتا الفجر"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(fajrPre: value),
                                );
                              });
                            },
                          ),
                          PrayerCountSelector(
                            numbers: const [0, 2, 4, 6, 8],
                            value: dailyDeeds.additionalPrayers.doha,
                            title: const Text("الضحى"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(doha: value),
                                );
                              });
                            },
                          ),
                          PrayerCountSelector(
                            numbers: const [0, 4],
                            value: dailyDeeds.additionalPrayers.dhuhrPre,
                            title: const Text("الظهر القبليه"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(dhuhrPre: value),
                                );
                              });
                            },
                          ),
                          PrayerCountSelector(
                            numbers: const [0, 2, 4],
                            value: dailyDeeds.additionalPrayers.dhuhrAfter,
                            title: const Text("الظهر البعديه"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(dhuhrAfter: value),
                                );
                              });
                            },
                          ),
                          PrayerCountSelector(
                            numbers: const [0, 4],
                            value: dailyDeeds.additionalPrayers.asrPre,
                            title: const Text("العصر القبليه"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(asrPre: value),
                                );
                              });
                            },
                          ),
                          PrayerCountSelector(
                            numbers: const [0, 2],
                            value: dailyDeeds.additionalPrayers.maghribPre,
                            title: const Text("المغرب القبليه"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(maghribPre: value),
                                );
                              });
                            },
                          ),
                          PrayerCountSelector(
                            numbers: const [0, 2],
                            value: dailyDeeds.additionalPrayers.maghribAfter,
                            title: const Text("المغرب البعديه"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(maghribAfter: value),
                                );
                              });
                            },
                          ),
                          PrayerCountSelector(
                            numbers: const [0, 2],
                            value: dailyDeeds.additionalPrayers.ishaaPre,
                            title: const Text("العشاء القبليه"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(ishaaPre: value),
                                );
                              });
                            },
                          ),
                          PrayerCountSelector(
                            numbers: const [0, 2],
                            value: dailyDeeds.additionalPrayers.ishaaAfter,
                            title: const Text("العشاء البعديه"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(ishaaAfter: value),
                                );
                              });
                            },
                          ),
                          PrayerCountSelector(
                            numbers: const [
                              0,
                              1,
                              3,
                              5,
                              7,
                              9,
                              11,
                              13,
                              15,
                              17,
                              19,
                              21,
                            ],
                            value: dailyDeeds.additionalPrayers.nightPrayer,
                            title: const Text("صلاة الليل"),
                            onChanged: (value) {
                              setState(() {
                                dailyDeeds = dailyDeeds.copyWith(
                                  additionalPrayers: dailyDeeds
                                      .additionalPrayers
                                      .copyWith(nightPrayer: value),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('الغاء', textAlign: TextAlign.center),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('تم', textAlign: TextAlign.center),
                        onTap: () {
                          Navigator.of(context).pop(dailyDeeds);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
