import 'package:flutter/material.dart';

class ChatsTab extends StatelessWidget {
  final titleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 36);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text('Chats', style: titleStyle),
          ),
          Container(),
        ],
      ),
    ));
  }
}
