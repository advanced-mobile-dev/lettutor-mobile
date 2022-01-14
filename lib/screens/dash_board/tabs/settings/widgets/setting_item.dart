import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final Function() function;
  final String title;
  SettingItem({
    @required this.function,
    @required this.title,
  });

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
