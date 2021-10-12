import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/models/teacher.dart';

class UpcommingClassItem extends StatelessWidget {
  final Teacher teacher;
  final DateTime startMeeting;
  final DateTime endMeeting;
  UpcommingClassItem(
      {@required this.teacher,
      @required this.startMeeting,
      @required this.endMeeting});

  final ButtonStyle _cancelButtonStyle = OutlinedButton.styleFrom(
    primary: AppTheme.redColor,
    side: BorderSide(color: AppTheme.redColor, width: 1.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );
  final ButtonStyle _joinButtonStyle = OutlinedButton.styleFrom(
    primary: AppTheme.mainColor,
    side: BorderSide(color: AppTheme.mainColor, width: 1.5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  final ButtonStyle _sendMessageButtonStyle = OutlinedButton.styleFrom(
    primary: Colors.black,
    side: BorderSide(color: Colors.black, width: 0.5),
    padding: EdgeInsets.all(5),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );
  final TextStyle textStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

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
                                    _sendMessageButton(() => {})
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
                    _cancelButton(() => {}),
                    SizedBox(
                      width: 10,
                    ),
                    _joinButton(() => {})
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _sendMessageButton(Function() function) {
    return OutlinedButton(
        style: _sendMessageButtonStyle,
        onPressed: function,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.message,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Send message', style: textStyle)
          ],
        ));
  }

  Widget _cancelButton(Function() function) {
    return OutlinedButton(
        style: _cancelButtonStyle,
        onPressed: function,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.cancel,
              color: AppTheme.redColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Cancel', style: textStyle)
          ],
        ));
  }

  Widget _joinButton(Function() function) {
    return OutlinedButton(
        style: _joinButtonStyle,
        onPressed: function,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.video_call_rounded,
            ),
            SizedBox(
              width: 5,
            ),
            Text('Go to meeting', style: textStyle)
          ],
        ));
  }
}
