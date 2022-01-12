import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/utils/device_utils.dart';

class ApplicationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  ApplicationAppBar({@required this.title, this.actions = const <Widget>[]});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          onPressed: () {
            DeviceUtils.hideKeyboard(context);
            Navigator.pop(context);
          }),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
            fontSize: AppSizes.normalTextSize,
            color: Theme.of(context).primaryColor),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
