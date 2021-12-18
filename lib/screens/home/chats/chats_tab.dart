import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/tutor.dart';
import 'package:lettutor_app/screens/home/chats/chat_item.dart';

class ChatsTab extends StatelessWidget {
  final titleStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.hugeTextSize);
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
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: 'Search...',
                        hintStyle:
                            TextStyle(fontSize: AppSizes.normalTextSize)),
                  ),
                ),
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
