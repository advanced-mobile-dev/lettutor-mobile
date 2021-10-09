import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final Function function;

  SubmitButton({@required this.text, @required this.function});
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: AppTheme.mainColor,
      minimumSize: Size(double.infinity, 50),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
    );
  }
}
