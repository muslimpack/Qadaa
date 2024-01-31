import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/managers/transition_animation.dart';
import 'package:qadaa/src/features/daily_deeds/presentation/screens/daily_deeds_dashboard.dart';
import 'package:qadaa/src/features/missed_deeds/presentation/screens/missed_deeds_screen.dart';
import 'package:qadaa/src/features/settings/presentation/screens/settings.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          MissedDeedsScreen(),
          DailyDeedsDashBoard(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tabController.index,
        onDestinationSelected: (value) {
          setState(() {
            tabController.animateTo(value);
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.mosque),
            label: " قضاء",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            label: " المتابعة اليومية",
          ),
        ],
      ),
    );
  }
}
