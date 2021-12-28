import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/screens/tutor_profile/tutor_profile.dart';
import 'package:lettutor_app/utils/string_utils.dart';

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
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3))
            ]),
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    ClipOval(
                      child: Image.network(
                        tutor.tutorBasicInfo.avatar,
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tutor.tutorBasicInfo.name,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/national_flags/${tutor.tutorBasicInfo.country.toLowerCase()}.png',
                              height: 15,
                              width: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                StringUtils.getCountryNameByCode(
                                    tutor.tutorBasicInfo.country),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: AppSizes.smallTextSize))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              // '${5}',
                              '${tutor.avgRating ?? 5}',
                              style: TextStyle(color: Colors.amber),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 100,
                              child: RatingBar.builder(
                                initialRating: tutor.avgRating ?? 5,
                                ignoreGestures: true,
                                itemSize: 15,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                )),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
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
