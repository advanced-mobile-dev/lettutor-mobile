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
              color: AppTheme.mainColor,
            ),
            onPressed: () {
              Utility.hideKeyboard(context);
              Navigator.pop(context);
            }),
        backgroundColor: AppTheme.mainColor2,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
              color: AppTheme.mainColor, fontSize: AppSizes.normalTextSize),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
