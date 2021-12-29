import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
