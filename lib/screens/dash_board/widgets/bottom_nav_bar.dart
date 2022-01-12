import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../dash_board.dart';

class BottomNavBar extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  BottomNavBar({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Fixed
      backgroundColor: Colors.white,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: AppLocalizations.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined),
          label: AppLocalizations.of(context).tutors,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded),
          label: AppLocalizations.of(context).courses,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications_sharp),
          label: AppLocalizations.of(context).settings,
        ),
      ],
    );
  }
}
