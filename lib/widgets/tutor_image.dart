import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:lettutor_app/constants/config.dart';
import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';

import 'network_circle_avatar.dart';

class TutorImageWidget extends StatelessWidget {
  const TutorImageWidget({
    Key key,
    @required this.tutorBasicInfo,
    @required this.height,
    @required this.showRating,
  }) : super(key: key);

  final TutorBasicInfo tutorBasicInfo;
  final double height;
  final bool showRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          NetworkCircleAvatar(
            url: tutorBasicInfo.avatar,
            radius: height / 2,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          tutorBasicInfo.name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontSize: 14 * height / 50),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/national_flags/${tutorBasicInfo.country.toLowerCase()}.png',
                      height: 15,
                      width: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      AppConfig.countries
                          .firstWhere((element) =>
                              element.code == tutorBasicInfo.country)
                          .name,
                      style: TextStyle(fontSize: 13 * height / 50),
                    )
                  ],
                ),
                showRating
                    ? Row(
                        children: [
                          Text(
                            '${tutorBasicInfo.calcAvgRating()}',
                            style: TextStyle(color: Colors.amber),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 100,
                            child: RatingBar.builder(
                              initialRating: tutorBasicInfo.calcAvgRating(),
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
                    : SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
