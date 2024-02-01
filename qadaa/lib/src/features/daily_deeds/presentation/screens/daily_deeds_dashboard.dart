import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/screens/daily_deeds_calender_view.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/screens/daily_deeds_statistics_view.dart';

class DailyDeedsDashBoard extends StatefulWidget {
  const DailyDeedsDashBoard({super.key});

  @override
  State<DailyDeedsDashBoard> createState() => _DailyDeedsDashBoardState();
}

class _DailyDeedsDashBoardState extends State<DailyDeedsDashBoard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
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
              tabs: <Widget>[
                Tab(
                  text: S.of(context).calender,
                ),
                Tab(
                  text: S.of(context).statistics,
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  DailyDeedsCalenderView(),
                  DailyDeedsStatisticsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
