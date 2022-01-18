import 'package:flutter/material.dart';
import 'package:lettutor_app/constants/colors.dart';

class DetailRow extends StatelessWidget {
  final String title;
  final Widget content;

  const DetailRow({Key key, this.title, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                '$title',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: AppColors.customGrey),
              )),
          Expanded(flex: 5, child: content)
        ],
      ),
    );
  }
}
