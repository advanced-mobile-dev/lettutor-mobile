import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseFilterWidget extends StatefulWidget {
  @override
  _CourseFilterWidgetState createState() => _CourseFilterWidgetState();
}

class _CourseFilterWidgetState extends State<CourseFilterWidget> {
  final textStyle = TextStyle(fontSize: AppSizes.smallTextSize);
  final levels = [
    'Any Level',
    'Beginner',
    'Upper Beginner',
    'Pre-Intermediate',
    'Intermediate',
    'Upper-Intermediate',
    'Pre-Advanced',
    'Advanced',
  ];

  final categories = [
    'All',
    'English for kids',
    'English for beginners',
    'Business English',
    'Conversational English',
    'For studying aboard',
    'English for traveling'
  ];

  String levelValue = 'Any Level';
  String categoryValue = 'All';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(
                  Icons.search,
                ),
                hintText: AppLocalizations.of(context).searchByName,
                hintStyle: TextStyle(fontSize: AppSizes.smallTextSize)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 70,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(AppLocalizations.of(context).levels,
                          style: textStyle),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1)),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: levelValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            underline: SizedBox(),
                            onChanged: (String newValue) {
                              setState(() {
                                levelValue = newValue;
                              });
                            },
                            items: levels
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ))
                    ]),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(AppLocalizations.of(context).categories,
                          style: textStyle),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1)),
                          child: DropdownButton<String>(
                            value: categoryValue,
                            isExpanded: true,
                            iconSize: 24,
                            underline: SizedBox(),
                            onChanged: (String newValue) {
                              setState(() {
                                categoryValue = newValue;
                              });
                            },
                            items: categories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ))
                    ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}
