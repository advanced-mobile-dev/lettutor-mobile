import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/tutors/tutors_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/utils/debouner.dart';
import 'package:lettutor_app/utils/device_utils.dart';

class TutorsSearchBar extends StatefulWidget {
  @override
  State<TutorsSearchBar> createState() => _TutorsSearchBarState();
}

class _TutorsSearchBarState extends State<TutorsSearchBar> {
  final _searchController = TextEditingController();
  Debouner _debouner = new Debouner(milliseconds: 1000);
  TutorsBloc _tutorsBloc;
  @override
  void initState() {
    _tutorsBloc = context.read<TutorsBloc>();
    _searchController.text = _tutorsBloc.tutorFilter.keyword;
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
            _tutorsBloc.add(ApplyTutorFilterEvent(
                tutorFilter: _tutorsBloc.tutorFilter.copyWith(keyword: value)));
            // DeviceUtils.hideKeyboard(context);
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
                DeviceUtils.hideKeyboard(context);

                if (_searchController.text.isNotEmpty) {
                  _searchController.clear();
                  _tutorsBloc.add(ApplyTutorFilterEvent(
                      tutorFilter:
                          _tutorsBloc.tutorFilter.copyWith(keyword: '')));
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
