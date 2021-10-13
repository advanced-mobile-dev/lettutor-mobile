import 'package:flutter/material.dart';

class CourseFilterWidget extends StatefulWidget {
  @override
  _CourseFilterWidgetState createState() => _CourseFilterWidgetState();
}

class _CourseFilterWidgetState extends State<CourseFilterWidget> {
  final textStyle = TextStyle(color: Colors.black, fontSize: 12);
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
        TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: 'Search course by name...',
              hintStyle: TextStyle(fontSize: 14)),
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
                      Text('Levels', style: textStyle),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(width: 1)),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: levelValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            style: const TextStyle(color: Colors.black),
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
                      Text('Categories', style: textStyle),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(width: 1)),
                          child: DropdownButton<String>(
                            value: categoryValue,
                            isExpanded: true,
                            iconSize: 24,
                            style: const TextStyle(color: Colors.black),
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
