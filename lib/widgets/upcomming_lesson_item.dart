import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/teacher.dart';
import 'package:lettutor_app/widgets/outline_button.dart';

class UpcommingClassItem extends StatelessWidget {
  final Teacher teacher;
  final DateTime startMeeting;
  final DateTime endMeeting;
  final bool upcommingLesson;
  UpcommingClassItem(
      {@required this.teacher,
      @required this.startMeeting,
      @required this.endMeeting,
      this.upcommingLesson = false});
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
      child: Column(
        children: <Widget>[
          upcommingLesson
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      color: AppTheme.mainColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Upcomming lesson',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        '9h 37m 11s',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                    teacher.avatar,
                                    fit: BoxFit.cover,
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
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
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Expanded(
                                              child: Text(
                                                teacher.name,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/national_flags/${teacher.countryCode}.png',
                                        height: 20,
                                        width: 40,
                                      ),
                                      // AppOutlineButton(
                                      //     text: 'Send message',
                                      //     function: () => {},
                                      //     iconData: Icons.message,
                                      //     color: Colors.black)
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
                                Text('11/10/2021'),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('20:00 - 20:25',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
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
                        width: 10,
                      ),
                      AppOutlineButton(
                          text: 'Go to meeting',
                          function: () => {},
                          iconData: Icons.video_call_rounded,
                          color: AppTheme.mainColor),
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
