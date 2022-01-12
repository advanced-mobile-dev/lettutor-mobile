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
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.blue, fontSize: 14),
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

  Future<void> customLaunch(context, String command) async {
    command = command.replaceAll(' ', '%20');
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Could not launch the pdf file')),
        );
    }
  }
}
