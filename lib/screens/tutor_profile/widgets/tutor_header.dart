import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/utils/string_utils.dart';

class TutorHeader extends StatelessWidget {
  final Tutor tutor;
  TutorHeader(this.tutor);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        child: Row(
          children: <Widget>[
            ClipOval(
              child: Image.network(
                tutor.tutorBasicInfo.avatar,
                width: 100.0,
              ),
            ),
            SizedBox(
              width: AppSizes.horizontalItemSpacing,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tutor.tutorBasicInfo.name,
                  style: TextStyle(
                      fontSize: AppSizes.normalTextSize,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '${tutor.tutorBasicInfo.calcAvgRating()}',
                      style: TextStyle(color: Colors.amber),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 90,
                      child: RatingBar.builder(
                        initialRating: tutor.tutorBasicInfo.calcAvgRating(),
                        ignoreGestures: true,
                        itemSize: AppSizes.normalTextSize,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    Text(
                      '(${tutor.tutorBasicInfo.feedbacks.length})',
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/national_flags/${tutor.tutorBasicInfo.country.toLowerCase()}.png',
                      height: 25,
                      width: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        StringUtils.getCountryNameByCode(
                            tutor.tutorBasicInfo.country),
                        style: TextStyle(
                          fontSize: AppSizes.normalTextSize,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ));
    ;
  }
}
