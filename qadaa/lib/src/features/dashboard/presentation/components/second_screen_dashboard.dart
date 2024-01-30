import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/constants/constant.dart';
import 'package:qadaa/src/core/managers/transition_animation.dart';
import 'package:qadaa/src/features/dashboard/presentation/components/pages/add_new.dart';
import 'package:qadaa/src/features/dashboard/presentation/components/pages/done.dart';
import 'package:qadaa/src/features/dashboard/presentation/components/pages/fasting.dart';
import 'package:qadaa/src/features/settings/presentation/screens/settings.dart';

class SecondScreenDashboard extends StatelessWidget {
  const SecondScreenDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.left,
            color: AppConstant.scrollColor,
            child: const TabBarView(
              //controller: tabController,
              physics: ClampingScrollPhysics(),
              children: [
                Done(),
                AddNew(),
                FastingPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
