import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/features/missed_deeds/presentation/components/pages/add_new.dart';
import 'package:qadaa/src/features/missed_deeds/presentation/components/pages/done.dart';
import 'package:qadaa/src/features/missed_deeds/presentation/components/pages/fasting.dart';

class MissedDeedsScreen extends StatelessWidget {
  const MissedDeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                  text: S.of(context).done_prayer,
                ),
                Tab(
                  text: S.of(context).missed_prayer,
                ),
                Tab(
                  text: S.of(context).fast,
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                //controller: tabController,
                physics: ClampingScrollPhysics(),
                children: [
                  Done(),
                  AddNew(),
                  FastingPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
