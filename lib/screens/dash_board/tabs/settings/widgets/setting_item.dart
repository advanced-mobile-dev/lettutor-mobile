import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';

class SettingItem extends StatelessWidget {
  final Function() function;
  final String title;
  SettingItem({
    @required this.function,
    @required this.title,
  });

  final TextStyle textStyle = TextStyle(
      fontSize: AppSizes.normalTextSize, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: function,
        child: Container(
          color: Colors.transparent,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: textStyle,
              ),
              const Expanded(child: SizedBox()),
              const Icon(Icons.keyboard_arrow_right),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ));
  }
}
