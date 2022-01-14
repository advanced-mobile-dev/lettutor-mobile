import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/models/tutor/tutor_feedback.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/network_circle_avatar.dart';

class TutorReviews extends StatelessWidget {
  final List<TutorFeedback> tutorFeedbacks;
  TutorReviews(this.tutorFeedbacks);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 15, top: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context).reviews,
                style: Theme.of(context).textTheme.headline6,
              )),
          Column(
            children: tutorFeedbacks.map((e) => RatingComment(e)).toList(),
          ),
          SizedBox(
            height: 30,
          )
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
      padding: EdgeInsets.symmetric(vertical: 15 * 1.5, horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: <Widget>[
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              NetworkCircleAvatar(
                url: feedback.feedbacker.avatar,
                radius: 15,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(feedback.feedbacker.name,
                      style: Theme.of(context).textTheme.subtitle1),
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
              Expanded(child: SizedBox()),
              Text(
                '${MyDateUtils.getCommentTime(DateTime.parse(feedback.createdAt))}',
                style: Theme.of(context).textTheme.caption,
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
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          )
        ],
      ),
    );
  }
}
