import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/widgets/outline_button.dart';

class TutorItemWidget extends StatelessWidget {
  final Tutor tutor;

  TutorItemWidget({this.tutor});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3))
          ]),
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  height: 60,
                  child: Row(
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          tutor.avatar,
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
                            tutor.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/national_flags/${tutor.countryCode}.png',
                                height: 15,
                                width: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(tutor.countryName,
                                  style: TextStyle(fontSize: 11))
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${tutor.rating}',
                                style: TextStyle(color: Colors.amber),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 100,
                                child: RatingBar.builder(
                                  initialRating: tutor.rating,
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
              IconButton(
                  alignment: Alignment.topRight,
                  icon: Icon(Icons.favorite_border),
                  onPressed: () => {}),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: Text(tutor.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(color: AppTheme.textColor, fontSize: 11)),
          ),
          // Container(
          //   height: 35,
          //   width: double.infinity,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: <Widget>[
          // AppOutlineButton(
          //     text: 'Favorite',
          //     function: () {},
          //     iconData: Icons.favorite,
          //     color: Colors.pink),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       AppOutlineButton(
          //           text: 'Detail',
          //           function: () {},
          //           iconData: Icons.description,
          //           color: AppTheme.mainColor)
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
