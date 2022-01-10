import 'package:flutter/material.dart';
import 'package:lettutor_app/models/course/category.dart';
import 'package:lettutor_app/models/course/course_level.dart';
import 'package:lettutor_app/models/filter/course_filter.dart';
import 'package:lettutor_app/widgets/multi-choice-tags.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class CourseFilterBottomSheet extends StatefulWidget {
  final CourseFilter tutorFilter;
  CourseFilterBottomSheet(this.tutorFilter);
  @override
  State<CourseFilterBottomSheet> createState() =>
      _CourseFilterBottomSheetState();
}

class _CourseFilterBottomSheetState extends State<CourseFilterBottomSheet> {
  List<CourseLevel> _selectedLevels = <CourseLevel>[];
  List<Category> _selectedCategories = <Category>[];
  int filter = 0;

  @override
  void initState() {
    super.initState();
    _selectedLevels.addAll(widget.tutorFilter.levels ?? []);
    _selectedCategories.addAll(widget.tutorFilter.categories ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Levels',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            MultiChoiceTags(
              selectedTags: _selectedLevels,
              options: CourseLevel.data,
              onChanged: (value) {
                if (value.isEmpty)
                  setState(() {});
                else
                  setState(() {});
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Categories ',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            MultiChoiceTags(
              selectedTags: _selectedCategories,
              options: Category.data,
              onChanged: (value) {
                if (value.isEmpty)
                  setState(() {});
                else
                  setState(() {});
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                onPressed: () {
                  print(_selectedLevels);
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubmitButton(
                          text: 'Clear',
                          backgroundColor: Colors.grey,
                          function: () {
                            setState(() {
                              _selectedLevels.clear();
                              _selectedCategories.clear();

                              Navigator.pop(
                                  context,
                                  widget.tutorFilter.levels.isEmpty
                                      ? null
                                      : CourseFilter(
                                          levels: _selectedLevels,
                                          categories: _selectedCategories));
                            });
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: SubmitButton(
                          text:
                              'Apply (${getFilterNumber(_selectedLevels, _selectedCategories)})',
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.8),
                          function: () {
                            Navigator.pop(
                                context,
                                CourseFilter(
                                    levels: _selectedLevels,
                                    categories: _selectedCategories));
                          }),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ]);
  }

  getFilterNumber(_selectedLevels, _selectedCategories) {
    if (_selectedLevels.isEmpty) {
      if (_selectedCategories.isEmpty) {
        return '';
      }
      return '1';
    } else {
      if (_selectedCategories.isEmpty) {
        return '1';
      }
      return '2';
    }
  }
}
