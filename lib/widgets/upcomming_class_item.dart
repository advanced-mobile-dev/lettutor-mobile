import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/teacher.dart';
import 'package:lettutor_app/widgets/outline_button.dart';

class UpcommingClassItem extends StatelessWidget {
  final Teacher teacher;
  final DateTime startMeeting;
  final DateTime endMeeting;
  UpcommingClassItem(
      {@required this.teacher,
      @required this.startMeeting,
      @required this.endMeeting});
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: <Widget>[
                    Flexible(
                        flex: 6,
                        child: Container(
                          height: double.infinity,
                          child: Row(
                            children: <Widget>[
                              // // teacher.avatar,
                              ClipOval(
                                child: Image.asset(
                                  teacher.avatar,
                                  fit: BoxFit.cover,
                                  width: 45.0,
                                  height: 45.0,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/national_flags/${teacher.countryCode}.png',
                                            height: 20,
                                            width: 40,
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Expanded(
                                            child: Text(
                                              teacher.name,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    AppOutlineButton(
                                        text: 'Send message',
                                        function: () => {},
                                        iconData: Icons.message,
                                        color: Colors.black)
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
        ));
  }
}
