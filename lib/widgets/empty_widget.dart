import 'package:flutter/material.dart';
import 'package:lettutor_app/constants/assets.dart';
import 'package:lettutor_app/constants/colors.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class EmptyWidget extends StatelessWidget {
  final Widget emptyWidget;
  final String content;
  final VoidCallback action;
  EmptyWidget(
      {this.content = 'No results found', this.action, this.emptyWidget});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: emptyWidget ??
              Image.asset(
                Assets.noDataImage,
                width: 100,
              ),
        ),
        SizedBox(
          height: 20,
        ),
        Text('$content'),
        SizedBox(
          height: 20,
        ),
        action != null
            ? SubmitButton(
                text: 'Book now',
                function: action,
                width: 100,
              )
            : SizedBox()
      ],
    );
  }
}
