import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:lettutor_app/models/config/speciality.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';

class TutorInfo extends StatelessWidget {
  final Tutor tutor;
  TutorInfo(this.tutor);
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
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
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
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1))
          ], borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          ));
    }

    List<String> specialities = tutor.specialties.split(',').map((s) {
      final Speciality speciality = Speciality.data.firstWhere(
          (element) => element.code.toLowerCase() == s,
          orElse: () => null);
      if (speciality == null) return '';
      return speciality.name;
    }).toList();
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
                  children: tutor.languages
                      .split(',')
                      .map((e) => _buildTag('$e'))
                      .toList(),
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
                  children: specialities.map((e) => _buildTag(e)).toList(),
                ),
              )),
          _buildDescItem(
              icon: SvgPicture.asset(
                'assets/icons/star-box-multiple.svg',
                color: Theme.of(context).primaryColor,
              ),
              title: AppLocalizations.of(context).interests,
              content: Text(
                '${tutor.interests}',
              )),
          _buildDescItem(
              icon: SvgPicture.asset(
                'assets/icons/suitcase.svg',
                color: Theme.of(context).primaryColor,
              ),
              title: AppLocalizations.of(context).teachingExperience,
              content: Text(
                '${tutor.experience}',
                textAlign: TextAlign.start,
              )),
        ],
      ),
    );
  }
}
