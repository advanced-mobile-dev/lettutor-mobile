import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';
import 'package:lettutor_app/widgets/icons.dart';

class TutorDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildDescItem(
              icon: AppIcons.languageIcon,
              title: 'Languages',
              content: Container(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    _buildTag('English'),
                    _buildTag('Vietnamese'),
                    _buildTag('Korean'),
                  ],
                ),
              )),
          _buildDescItem(
              icon: AppIcons.listIcon,
              title: 'Specialities',
              content: Container(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    _buildTag('Conversational'),
                    _buildTag('English for kids'),
                    _buildTag('English for business'),
                  ],
                ),
              )),
          _buildDescItem(
              icon: AppIcons.starBoxIcon,
              title: 'Interests',
              content: Text(
                'Watching English films and talking to friends from different countries',
              )),
          _buildDescItem(
              icon: AppIcons.suitCaseIcon,
              title: 'Teaching experience',
              content: Text(
                  'I have been teaching as an English teacher for over three years. I have been working for many English centers, including VUS and I am also a lecturer at HCM College of Economics. I have taught English at various levels, including English for Kids, English for Communication, TOEIC and IELTS.')),
        ],
      ),
    );
  }

  Widget _buildDescItem({Widget icon, String title, Widget content}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            icon,
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: content,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppTheme.secondaryColor),
        child: Text(
          text,
          style: TextStyle(color: AppTheme.primaryColor),
        ));
  }
}
