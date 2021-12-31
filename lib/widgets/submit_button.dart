import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/theme.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final Function function;
  final Color backgroundColor;
  final Color textColor;
  final Widget icon;
  final double width;
  final double height;
  SubmitButton(
      {@required this.text,
      @required this.function,
      this.backgroundColor,
      this.textColor = Colors.white,
      this.icon,
      this.width = double.infinity,
      this.height = 50});
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: textColor,
      primary: backgroundColor,
      minimumSize: Size(width, height),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: function,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null ? icon : SizedBox(),
          SizedBox(
            width: icon != null ? 10 : 0,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: AppSizes.normalTextSize,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
