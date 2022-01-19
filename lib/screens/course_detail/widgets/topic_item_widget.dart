import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:lettutor_app/models/course/topic.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/utils/url_launcher.dart';
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
                  Navigator.pushNamed(context, LettutorRoutes.topic,
                      arguments: topic);
                  // await AppUrlLauncher.launchHttpsUrl(context, topic.nameFile);
                },
            ),
          ],
        ),
      ),
    );
  }
}
