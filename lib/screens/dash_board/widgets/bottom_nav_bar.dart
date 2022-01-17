import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/blocs/bottom_nav/bottom_nav_bloc.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (BuildContext context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Fixed
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).iconTheme.color,
          currentIndex: state.tab.index,
          onTap: (index) =>
              context.read<BottomNavBloc>().add(TabChangeEvent(index)),
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
      },
    );
  }
}
