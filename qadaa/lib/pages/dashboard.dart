import 'package:qadaa/Screens/Settings.dart';
import 'package:qadaa/manager/constant.dart';
import 'package:qadaa/shared/widgets/bouncy_page.dart';
import 'package:flutter/material.dart';

import 'add_new.dart';
import 'done.dart';

class Qadaa extends StatefulWidget {
  const Qadaa({Key? key}) : super(key: key);

  @override
  _QadaaState createState() => _QadaaState();
}

class _QadaaState extends State<Qadaa> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
    tabController = TabController(initialIndex: 1, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("قضاء"),
          centerTitle: true,
          // leading: GestureDetector(
          //   onTap: () async {
          //     showModalBottomSheet(
          //         isScrollControlled: true,
          //         backgroundColor: Colors.transparent,
          //         context: context,
          //         builder: (BuildContext context) {
          //           return YesOrNoDialog(onYes: () {
          //             prayersSettings.reset();
          //           });
          //         }).then((value) {
          //       setState(() {});
          //     });
          //     // await showDialog(
          //     //   context: context,
          //     //   builder: (BuildContext context) {
          //     //     return YesOrNoDialog(onYes: () {
          //     //       prayersSettings.reset();
          //     //     });
          //     //   },
          //     // ).then((value) {
          //     //   setState(() {});
          //     // });
          //   },
          //   child: Icon(
          //     Icons.reset_tv,
          //     color: Colors.red.shade200,
          //     size: 30,
          //   ),
          // ),
          actions: [
            GestureDetector(
              onTap: () {
                // Navigator.push(context, TweenPageRoute(widget: Settings()));
                transitionAnimation.fromLeft2Right(
                    context: context, goToPage: const Settings());
                // print('Settings Tapped');
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
            indicatorColor: Colors.blue.shade200,
            labelColor: Colors.blue.shade200,
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
