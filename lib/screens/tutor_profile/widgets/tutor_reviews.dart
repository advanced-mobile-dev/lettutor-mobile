import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/models/tutor/tutor-feedback.dart';

class TutorReviews extends StatelessWidget {
  final List<TutorFeedback> tutorFeedbacks;
  TutorReviews(this.tutorFeedbacks);
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
            children: tutorFeedbacks.map((e) => RatingComment(e)).toList(),
          ),
        ],
      ),
    );
  }
}

class RatingComment extends StatelessWidget {
  final TutorFeedback feedback;
  RatingComment(this.feedback);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
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
                child: Image.network(
                  feedback.feedbacker.avatar,
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
                        feedback.feedbacker.name,
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
                        '${feedback.rating}',
                        style: TextStyle(color: Colors.amber),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 100,
                        child: RatingBar.builder(
                          initialRating: feedback.rating.toDouble(),
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
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              '${feedback.content}',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }
}
