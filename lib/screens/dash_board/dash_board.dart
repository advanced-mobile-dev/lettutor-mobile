import 'package:flutter/material.dart';

import 'package:lettutor_app/screens/dash_board/widgets/bottom_nav_bar.dart';
import 'tabs/courses/courses_tab.dart';
import 'tabs/home/home_tab.dart';
import 'tabs/settings/settings_tab.dart';
import 'tabs/tutors/tutors_tab.dart';

enum AppTab { home, tutors, courses, settings }

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final PageController _pageController = PageController();
  AppTab _currentTab;

  @override
  void initState() {
    _currentTab = AppTab.home;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentTab = AppTab.values[index];
              });
            },
            children: <Widget>[
              HomeTab(),
              TutorsTab(),
              CoursesTab(),
              SettingsTab(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
            activeTab: _currentTab,
            onTabSelected: (tab) {
              _pageController.jumpToPage(tab.index);
            }));
  }
}
