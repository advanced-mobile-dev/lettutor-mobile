import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/courses/courses_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
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
  Debouner _debouner = new Debouner(milliseconds: 500);
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
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
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
            prefixIcon: Icon(
              Icons.search,
            ),
            hintText: AppLocalizations.of(context).searchByName,
            hintStyle: TextStyle(
              fontSize: AppSizes.smallTextSize,
            ),
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
                color: Colors.grey[700],
              ),
            )),
      ),
    );
  }
}
