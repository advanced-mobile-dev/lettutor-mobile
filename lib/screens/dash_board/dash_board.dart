import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/screens/dash_board/widgets/bottom_nav_bar.dart';
import 'tabs/courses/courses_tab.dart';
import 'tabs/home/home_tab.dart';
import 'tabs/settings/settings_tab.dart';
import 'tabs/tutors/tutors_tab.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final PageController _pageController = PageController();
  // AppTab _currentTab;

  @override
  void initState() {
    // _currentTab = AppTab.home;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavBloc, BottomNavState>(
      listener: (BuildContext context, state) {
        if (state is BottomNavState) {
          _pageController.jumpToPage(state.tab.index);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
          ),
          body: SizedBox.expand(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                HomeTab(),
                TutorsTab(),
                CoursesTab(),
                SettingsTab(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavBar()),
    );
  }
}
