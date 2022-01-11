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
    return RichText(
      text: new TextSpan(
        children: [
          TextSpan(
            text: '${topic.orderCourse + 1}. ${topic.name}',
            style: new TextStyle(
                fontSize: AppSizes.normalTextSize, color: Colors.blue),
            recognizer: new TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunch('${topic.nameFile}'
                    // 'tel:0931922043'
                    )) {
                  await launch('${topic.nameFile}'
                      // 'tel:0931922043'
                      );
                } else {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('Can not open the topic!!')),
                    );
                }
              },
          ),
        ],
      ),
    );
  }
}
