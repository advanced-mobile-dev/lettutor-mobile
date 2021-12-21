import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/config/utility.dart';

class ApplicationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  ApplicationAppBar({@required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Utility.hideKeyboard(context);
              Navigator.pop(context);
            }),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          title,
          style: TextStyle(
              fontSize: AppSizes.largeTextSize,
              color: Theme.of(context).primaryColor),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
