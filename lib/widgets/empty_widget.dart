import 'package:flutter/material.dart';
import 'package:lettutor_app/config/assets.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            Assets.noDataImage,
            width: 100,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text('No results found')
      ],
    );
  }
}
