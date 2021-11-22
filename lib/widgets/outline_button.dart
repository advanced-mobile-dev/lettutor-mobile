import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';

class AppOutlineButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color color;
  final Function function;

  AppOutlineButton(
      {@required this.text,
      @required this.function,
      @required this.iconData,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _buttonStyle = OutlinedButton.styleFrom(
      primary: color,
      side: BorderSide(color: color, width: 1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
    return OutlinedButton(
        style: _buttonStyle,
        onPressed: function,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              iconData,
              color: color,
            ),
            SizedBox(
              width: 5,
            ),
            Text(text,
                style: TextStyle(
                    fontSize: AppSizes.smallTextSize,
                    fontWeight: FontWeight.w400))
          ],
        ));
  }
}
