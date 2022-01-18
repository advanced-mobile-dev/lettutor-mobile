import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color color;
  final Function function;

  CustomTextButton(
      {@required this.text,
      @required this.function,
      @required this.iconData,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _buttonStyle = OutlinedButton.styleFrom(
      primary: color,
      side: BorderSide(color: color, width: 0),
      padding: EdgeInsets.symmetric(horizontal: 10),
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
            iconData == null
                ? SizedBox()
                : Icon(
                    iconData,
                    color: color,
                    size: 20,
                  ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
            )
          ],
        ));
  }
}
