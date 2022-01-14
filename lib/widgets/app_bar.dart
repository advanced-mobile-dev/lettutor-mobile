import 'package:flutter/material.dart';

import 'package:lettutor_app/utils/device_utils.dart';

class ApplicationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Color backgroundColor;

  ApplicationAppBar(
      {@required this.title,
      this.actions = const <Widget>[],
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            DeviceUtils.hideKeyboard(context);
            Navigator.pop(context);
          }),
      backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
