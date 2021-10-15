import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController controller;
  NameTextField({@required this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Name',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14, color: AppTheme.mainColor)),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.mainColor),
                  borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.mainColor2),
                  borderRadius: BorderRadius.circular(10)),
            ),
            cursorColor: AppTheme.mainColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (!isValidName(value)) return 'Invalid name';
              return null;
            },
          ),
        ]);
  }

  bool isValidName(String string) {
    return string.length > 0;
  }
}
