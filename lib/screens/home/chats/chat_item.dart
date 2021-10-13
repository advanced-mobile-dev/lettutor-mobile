import 'package:flutter/material.dart';
import 'package:lettutor_app/models/tutor.dart';

class ChatItem extends StatelessWidget {
  final Tutor tutor;
  final String latestMessage;

  ChatItem({this.tutor, this.latestMessage});

  final TextStyle nameStyle = TextStyle(fontSize: 14, color: Colors.black);
  final TextStyle latestMessageStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(primary: Color(0xff77838F)),
        onPressed: () {},
        child: Container(
          height: 70,
          padding: EdgeInsets.all(5),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(tutor.avatar),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ))
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(tutor.name, style: nameStyle),
                      Text(latestMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: latestMessageStyle),
                    ],
                  ),
                ),
              ),
              Container(
                width: 70,
                alignment: Alignment.topRight,
                child: Text(
                  '5 hour',
                  style: latestMessageStyle,
                ),
              ),
            ],
          ),
        ));
  }
}
