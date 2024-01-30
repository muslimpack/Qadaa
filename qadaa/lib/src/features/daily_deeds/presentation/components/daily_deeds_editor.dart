// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/features/daily_deeds/data/models/daily_deeds.dart';

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
  late final DailyDeeds dailyDeeds;
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
        constraints: const BoxConstraints(maxHeight: 500),
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
                    children: [
                      Container(
                        color: Colors.amber,
                      ),
                      Container(
                        color: Colors.green,
                      ),
                      Container(
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
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
