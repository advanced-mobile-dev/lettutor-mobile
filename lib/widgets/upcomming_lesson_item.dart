import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/colors.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/widgets/outline_button.dart';

class UpcommingLessonItem extends StatelessWidget {
  final Tutor tutor;
  final DateTime startMeeting;
  final DateTime endMeeting;
  final bool upcommingLesson;
  UpcommingLessonItem(
      {@required this.tutor,
      @required this.startMeeting,
      @required this.endMeeting,
      this.upcommingLesson = false});
  @override
  Widget build(BuildContext context) {
    return Container(
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
          upcommingLesson
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Upcomming lesson',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.smallTextSize),
                      ),
                      Text(
                        '9h 37m 11s',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.smallTextSize),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.all(AppSizes.cardPadding),
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          flex: 6,
                          child: Container(
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipOval(
                                  child: Image.asset(
                                    tutor.avatar,
                                    fit: BoxFit.cover,
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                                SizedBox(
                                  width: AppSizes.verticalItemSpacing,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                tutor.name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        AppSizes.normalTextSize,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      AppSizes.smallTextSize))
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                      Flexible(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '11/10/2021',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AppSizes.smallTextSize),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('20:00 - 20:25',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AppSizes.smallTextSize,
                                    )),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppSizes.verticalItemSpacing,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AppOutlineButton(
                          text: 'Cancel',
                          function: () => {},
                          iconData: Icons.cancel,
                          color: Colors.red),
                      SizedBox(
                        width: AppSizes.horizontalItemSpacing,
                      ),
                      AppOutlineButton(
                          text: 'Go to meeting',
                          function: () => {
                                Navigator.of(context)
                                    .pushNamed(LettutorRoutes.videoConference)
                              },
                          iconData: Icons.video_call_rounded,
                          color: Theme.of(context).primaryColor),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
