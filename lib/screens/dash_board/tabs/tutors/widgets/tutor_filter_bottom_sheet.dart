import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/constants/colors.dart';
import 'package:lettutor_app/models/config/speciality.dart';
import 'package:lettutor_app/models/filter/tutor_filter.dart';
import 'package:lettutor_app/widgets/multi-choice-tags.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

class TutorFilterBottomSheet extends StatefulWidget {
  final TutorFilter tutorFilter;
  TutorFilterBottomSheet(this.tutorFilter);
  @override
  State<TutorFilterBottomSheet> createState() => _TutorFilterBottomSheetState();
}

class _TutorFilterBottomSheetState extends State<TutorFilterBottomSheet> {
  List<Speciality> _selectedSpec = <Speciality>[];
  int filter = 0;

  @override
  void initState() {
    super.initState();
    _selectedSpec.addAll(widget.tutorFilter.specialities);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context).specialities,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 15,
            ),
            MultiChoiceTags(
              selectedTags: _selectedSpec,
              options: Speciality.data,
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
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  print(_selectedSpec);
                },
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SubmitButton(
                          text: 'Clear',
                          backgroundColor: AppColors.customGrey,
                          textColor: Colors.white,
                          function: () {
                            setState(() {
                              _selectedSpec.clear();

                              Navigator.pop(
                                  context,
                                  widget.tutorFilter.specialities.isEmpty
                                      ? null
                                      : TutorFilter(
                                          specialities: _selectedSpec));
                            });
                          }),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: SubmitButton(
                          text: 'Apply ${_selectedSpec.isEmpty ? '' : '(1)'}',
                          backgroundColor: AppColors.primaryColor[900],
                          function: () {
                            Navigator.pop(context,
                                TutorFilter(specialities: _selectedSpec));
                          }),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ]);
  }
}
