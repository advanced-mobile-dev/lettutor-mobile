import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_list/tutor_filter_widget.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_list/tutor_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorsTab extends StatelessWidget {
  final List<Tutor> tutorList = [
    Tutor.data,
    Tutor.data1,
    Tutor.data2,
    Tutor.data3
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.all(AppSizes.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppLocalizations.of(context).tutors,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.hugeTextSize)),
          SizedBox(
            height: AppSizes.verticalItemSpacing,
          ),
          Container(child: TutorFilterWidget()),
          SizedBox(
            height: 15,
          ),
          for (var element in tutorList) ...[
            TutorItemWidget(tutor: element),
            SizedBox(
              height: 15,
            )
          ]
        ],
      ),
    ));
  }
}
