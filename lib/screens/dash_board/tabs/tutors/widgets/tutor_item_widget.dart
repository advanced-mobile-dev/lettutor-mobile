import 'package:flutter/material.dart';
import 'package:lettutor_app/models/config/speciality.dart';

import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

class TutorItemWidget extends StatelessWidget {
  final Tutor tutor;

  TutorItemWidget({this.tutor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, LettutorRoutes.tutorProfile,
            arguments: tutor.userId);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(0),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.grey.withOpacity(0.5),
          //       spreadRadius: 1,
          //       blurRadius: 7,
          //       offset: Offset(1, 3))
          // ]
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          children: <Widget>[
            TutorImageWidget(
                tutorBasicInfo: tutor.tutorBasicInfo,
                height: 60,
                showRating: true),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  ...tutor.specialties
                      .split(',')
                      .map((e) => Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 1))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(bottom: 6, right: 6),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                                Speciality.data
                                    .firstWhere((element) => element.code == e)
                                    .name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                        fontSize: 12, color: Colors.black)),
                          ))
                      .toList()
                ],
              ),
            ),
            SizedBox(
              height: 10 / 2,
            ),
            Container(
              width: double.infinity,
              child: Text(tutor.bio,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.subtitle2),
            ),
          ],
        ),
      ),
    );
  }
}
