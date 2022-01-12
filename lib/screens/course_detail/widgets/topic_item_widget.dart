import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/course/topic.dart';
import 'package:url_launcher/url_launcher.dart';

class TopicItemWidget extends StatelessWidget {
  final Topic topic;
  TopicItemWidget(this.topic);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: RichText(
        text: new TextSpan(
          children: [
            TextSpan(
              text: '${topic.orderCourse + 1}. ${topic.name}',
              style: new TextStyle(
                  fontSize: AppSizes.normalTextSize, color: Colors.blue),
              recognizer: new TapGestureRecognizer()
                ..onTap = () async {
                  await customLaunch(context, topic.nameFile);
                  // if (await canLaunch('${topic.nameFile}')) {
                  //   await launch('${topic.nameFile}');
                  // } else {
                  //   ScaffoldMessenger.of(context)
                  //     ..hideCurrentSnackBar()
                  //     ..showSnackBar(
                  //       SnackBar(content: Text('Can not open the topic!!')),
                  //     );
                  // }
                },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> customLaunch(context, command) async {
    if (await canLaunch(command)) {
      await launch(command).catchError((onError) {
        print(onError);
      });
    } else {
      print('Could not launch $command');
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Could not launch the pdf file')),
        );
    }
  }
}
