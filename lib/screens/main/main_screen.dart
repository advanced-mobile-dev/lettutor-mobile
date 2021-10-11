import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/screens/main/home_screen.dart';
import 'package:lettutor_app/widgets/icons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: ',
    ),
    Text(
      'Index 2: ',
    ),
    Text(
      'Index 3: ',
    ),
    Text(
      'Index 4: ',
    ),
    Text(
      'Index 5: ',
    ),
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
            label: 'E-book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
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
