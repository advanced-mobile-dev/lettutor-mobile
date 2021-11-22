import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/screens/home/chats/chats_tab.dart';
import 'package:lettutor_app/screens/home/courses/courses_tab.dart';
import 'package:lettutor_app/screens/home/schedule/home_tab.dart';
import 'package:lettutor_app/screens/home/settings/settings_tab.dart';
import 'package:lettutor_app/screens/home/tutors/tutors_tab.dart';
import 'package:lettutor_app/widgets/icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    TutorsTab(),
    CoursesTab(),
    // ChatsTab(),
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
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.mainColor2,
        elevation: 0,
        title: AppIcons.appLogo,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Tutors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: 'Courses',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.message),
          //   label: 'Chats',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: AppTheme.mainColor,
        unselectedItemColor: AppTheme.unactiveColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
