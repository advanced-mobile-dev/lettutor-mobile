import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context).reviews,
                style: TextStyle(
                    fontSize: AppSizes.normalTextSize,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: AppSizes.verticalItemSpacing,
          ),
          Column(
            children: <Widget>[
              RatingComment(),
              SizedBox(height: AppSizes.verticalItemSpacing),
              RatingComment(),
              SizedBox(height: AppSizes.verticalItemSpacing),
              RatingComment(),
              SizedBox(height: AppSizes.verticalItemSpacing),
              RatingComment(),
              SizedBox(height: AppSizes.verticalItemSpacing),
              RatingComment(),
              SizedBox(height: AppSizes.verticalItemSpacing),
            ],
          ),
        ],
      ),
    );
  }
}

class RatingComment extends StatelessWidget {
  const RatingComment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.pagePadding * 1.5,
          horizontal: AppSizes.pagePadding),
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
      child: Column(
        children: <Widget>[
          Container(
              child: Row(
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  Tutor.data.avatar,
                  width: 30.0,
                  height: 30.0,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        Tutor.data.name,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '16 days ago',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${Tutor.data.rating}',
                        style: TextStyle(color: Colors.amber),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 100,
                        child: RatingBar.builder(
                          initialRating: Tutor.data.rating,
                          ignoreGestures: true,
                          itemSize: 15,
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
                    ],
                  )
                ],
              ),
            ],
          )),
          Text(
            'This is an excellent teacher. He is very talented and kind',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
