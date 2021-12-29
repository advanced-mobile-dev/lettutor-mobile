import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/blocs/tutors/tutors_bloc.dart';
import 'tabs/courses/courses_tab.dart';
import 'tabs/home/home_tab.dart';
import 'tabs/settings/settings_tab.dart';
import 'tabs/tutors/tutors_tab.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    BlocProvider(
      create: (_) => TutorsBloc(),
      child: TutorsTab(),
    ),
    CoursesTab(),
    SettingsTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Container(
        // margin: MediaQuery.of(context).padding,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: AppLocalizations.of(context).tutors,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: AppLocalizations.of(context).courses,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(context).settings,
          ),
        ],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
