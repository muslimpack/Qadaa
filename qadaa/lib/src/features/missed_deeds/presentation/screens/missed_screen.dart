import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/managers/transition_animation.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/screens/daily_prayers.dart';
import 'package:qadaa/src/features/missed_deeds/presentation/components/pages/add_new.dart';
import 'package:qadaa/src/features/missed_deeds/presentation/components/pages/done.dart';
import 'package:qadaa/src/features/missed_deeds/presentation/components/pages/fasting.dart';
import 'package:qadaa/src/features/settings/presentation/screens/settings.dart';

class MissedScreen extends StatelessWidget {
  const MissedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).qadaa),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                transitionAnimation.fromLeft2Right(
                  context: context,
                  goToPage: const Settings(),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
          bottom: TabBar(
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
              const Tab(
                text: "المتابعة اليومية",
              ),
              Tab(
                text: S.of(context).fast,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          //controller: tabController,
          physics: ClampingScrollPhysics(),
          children: [
            Done(),
            AddNew(),
            DailyPrayers(),
            FastingPage(),
          ],
        ),
      ),
    );
  }
}
