import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ));
    }

    return Container(
      child: Column(
        children: <Widget>[
          _buildDescItem(
              icon: SvgPicture.asset(
                'assets/icons/language.svg',
                color: Theme.of(context).primaryColor,
              ),
              title: AppLocalizations.of(context).languages,
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
              icon: SvgPicture.asset(
                'assets/icons/view-list.svg',
                color: Theme.of(context).primaryColor,
              ),
              title: AppLocalizations.of(context).specialities,
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
              icon: SvgPicture.asset(
                'assets/icons/star-box-multiple.svg',
                color: Theme.of(context).primaryColor,
              ),
              title: AppLocalizations.of(context).interests,
              content: Text(
                'Watching English films and talking to friends from different countries',
              )),
          _buildDescItem(
              icon: SvgPicture.asset(
                'assets/icons/suitcase.svg',
                color: Theme.of(context).primaryColor,
              ),
              title: AppLocalizations.of(context).teachingExperience,
              content: Text(
                  'I have been teaching as an English teacher for over three years. I have been working for many English centers, including VUS and I am also a lecturer at HCM College of Economics. I have taught English at various levels, including English for Kids, English for Communication, TOEIC and IELTS.')),
        ],
      ),
    );
  }
}
