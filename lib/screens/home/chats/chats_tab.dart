import 'package:flutter/material.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/home/chats/chat_item.dart';

class ChatsTab extends StatelessWidget {
  final titleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 36);
  final tutors = [
    Tutor.data,
    Tutor.data1,
    Tutor.data2,
    Tutor.data3,
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text('Chats', style: titleStyle),
          ),
          Container(
            child: Column(
              children: <Widget>[
                ...tutors
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ChatItem(
                            tutor: e,
                            latestMessage:
                                'Duis eget nibh tincidunt odio id venenatis ornare quis',
                          ),
                        ))
                    .toList()
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
