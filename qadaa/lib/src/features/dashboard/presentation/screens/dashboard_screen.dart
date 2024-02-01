import 'package:flutter/material.dart';
import 'package:qadaa/generated/l10n.dart';
import 'package:qadaa/src/core/managers/transition_animation.dart';
import 'package:qadaa/src/core/utils/open_url.dart';
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
          IconButton(
            onPressed: () {
              openURL(
                "https://play.google.com/store/apps/dev?id=4949997098744780639",
              );
            },
            icon: const Icon(
              Icons.more_vert,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              transitionAnimation.fromLeft2Right(
                context: context,
                goToPage: const Settings(),
              );
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
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
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.mosque),
            label: S.of(context).missedDeeds,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month_outlined),
            label: S.of(context).dailyDeeds,
          ),
        ],
      ),
    );
  }
}
