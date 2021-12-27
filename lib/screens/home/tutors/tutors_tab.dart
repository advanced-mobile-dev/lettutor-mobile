import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_list/tutor_filter_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/screens/home/tutors/tutor_list/tutor_list_widget.dart';

class TutorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).tutors,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizes.hugeTextSize)),
                Badge(
                  showBadge: false,
                  badgeContent: Text(
                    '0',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_list_alt,
                        size: 36,
                      )),
                )
              ],
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Visibility(visible: true, child: TutorFilterWidget()),
            SizedBox(
              height: 15,
            ),
            Expanded(child: TutorListWidget())
          ],
        ));
  }
}
