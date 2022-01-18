import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/courses/courses_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/utils/debouner.dart';
import 'package:lettutor_app/utils/device_utils.dart';

class SearchBar extends StatefulWidget {
  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchController = TextEditingController();
  Debouner _debouner = new Debouner(milliseconds: 1000);
  CoursesBloc _coursesBloc;
  @override
  void initState() {
    _coursesBloc = context.read<CoursesBloc>();

    _searchController.text = _coursesBloc.courseFilter.keyword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: _searchController,
        onChanged: (value) {
          _debouner.run(() {
            _coursesBloc.add(ApplyCourseFilterEvent(
                courseFilter:
                    _coursesBloc.courseFilter.copyWith(keyword: value)));
          });
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            hintText: AppLocalizations.of(context).searchByName,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.grey),
            suffixIcon: IconButton(
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  _searchController.clear();

                  _coursesBloc.add(ApplyCourseFilterEvent(
                      courseFilter:
                          _coursesBloc.courseFilter.copyWith(keyword: '')));
                  DeviceUtils.hideKeyboard(context);
                }
              },
              icon: Icon(
                Icons.clear,
                size: 24,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
