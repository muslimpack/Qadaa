import 'package:qadaa/Pages/Dashboard.dart';
import 'package:qadaa/manager/constant.dart';
import 'package:qadaa/manager/notification_manager.dart';
import 'package:qadaa/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final PageController _controller;
  int currentPageIndex = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification) {
    DoNothingAction();
  }

  onNotificationClick(String payload) {
    DoNothingAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: AppConstant.scrollColor,
          child: PageView(
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            scrollDirection: Axis.vertical,
            children: const [
              SplashScreen(),
              Qadaa(),
            ],
            onPageChanged: (value) {
              setState(() {
                currentPageIndex = value;
              });
            },
          ),
        ),
      ),
      floatingActionButton: currentPageIndex == 0
          ? null
          : FloatingActionButton(
              mini: true,
              backgroundColor: AppConstant.mainColor,
              onPressed: () {
                setState(() {
                  _controller.animateTo(0.0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear);
                  // _controller.jumpToPage(0);
                });
              },
              tooltip: 'Increment',
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
    );
  }
}
