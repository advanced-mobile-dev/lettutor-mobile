import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/widgets/app_bar.dart';

class VideoConference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationAppBar(
        title: 'Video conference',
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blue[200],
          ),
          Center(
            child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text('06:12:24',
                        style: TextStyle(color: Colors.white, fontSize: 15)))),
          ),
        ],
      ),
    );
  }
}
