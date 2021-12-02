import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/upcomming_lesson.dart';
import 'package:lettutor_app/widgets/outline_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpcommingLessonWidget extends StatelessWidget {
  final UpcommingLesson upcommingLesson;
  final bool isNearestLesson;
  UpcommingLessonWidget(
      {@required this.upcommingLesson, this.isNearestLesson = false});
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
          upcommingLesson.id == 1
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
                        AppLocalizations.of(context).upcommingLesson,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppSizes.smallTextSize),
                      ),
                      Text(
                        '9h 37m',
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
                                    upcommingLesson.tutor.avatar,
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
                                                upcommingLesson.tutor.name,
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
                                            'assets/national_flags/${upcommingLesson.tutor.countryCode}.png',
                                            height: 15,
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              upcommingLesson.tutor.countryName,
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
                                  upcommingLesson.date,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: AppSizes.smallTextSize),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(upcommingLesson.time,
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
                          text: AppLocalizations.of(context).cancel,
                          function: () => {
                                UpcommingLesson.sampleData
                                    .removeAt(upcommingLesson.id)
                              },
                          iconData: Icons.cancel,
                          color: Colors.red),
                      SizedBox(
                        width: AppSizes.horizontalItemSpacing,
                      ),
                      AppOutlineButton(
                          text: AppLocalizations.of(context).goToMeeting,
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
