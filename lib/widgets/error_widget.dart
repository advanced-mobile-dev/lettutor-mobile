import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final VoidCallback retry;
  AppErrorWidget({this.retry});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Icon(
            Icons.warning_amber_rounded,
            size: 100,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text('Something went wrong!!!'),
        SizedBox(
          height: 20,
        ),
        retry != null
            ? OutlinedButton(onPressed: retry, child: Text('Try again'))
            : SizedBox()
      ],
    );
  }
}
