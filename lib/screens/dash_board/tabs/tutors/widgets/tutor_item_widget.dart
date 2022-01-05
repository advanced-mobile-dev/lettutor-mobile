import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/speciality.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/screens/tutor_profile/tutor_profile.dart';
import 'package:lettutor_app/utils/string_utils.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

class TutorItemWidget extends StatelessWidget {
  final Tutor tutor;

  TutorItemWidget({this.tutor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TutorProfile(tutor: tutor)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(1, 3))
            ]),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
        child: Column(
          children: <Widget>[
            TutorImageWidget(
                tutorBasicInfo: tutor.tutorBasicInfo,
                size: 60,
                showRating: true),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
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
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              Speciality.data
                                  .firstWhere((element) => element.code == e)
                                  .name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: AppSizes.smallTextSize),
                            ),
                          ))
                      .toList()
                ],
              ),
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing / 2,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: Text(tutor.bio,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.black, fontSize: AppSizes.smallTextSize)),
            ),
          ],
        ),
      ),
    );
  }
}
