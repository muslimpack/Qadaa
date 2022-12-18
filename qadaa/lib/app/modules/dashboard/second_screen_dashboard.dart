import 'package:qadaa/app/modules/settings/settings.dart';
import 'package:qadaa/app/shared/widgets/bouncy_page.dart';
import 'package:qadaa/core/values/constant.dart';
import 'package:flutter/material.dart';

import 'pages/add_new.dart';
import 'pages/done.dart';

class SecondScreenDashboard extends StatelessWidget {
  const SecondScreenDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("قضاء"),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                transitionAnimation.fromLeft2Right(
                    context: context, goToPage: const Settings());
              },
              child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
          ],
          bottom: TabBar(
            indicatorColor: AppConstant.mainColor,
            labelColor: AppConstant.mainColor,
            unselectedLabelColor: Colors.white,
            tabs: const <Widget>[
              Tab(
                text: "تم قضاءها",
              ),
              Tab(
                text: "فروض جديدة",
              )
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
