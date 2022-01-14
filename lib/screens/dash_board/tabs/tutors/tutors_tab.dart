import 'package:flutter/material.dart';
import 'widgets/tab_header.dart';
import 'widgets/tutor_list_widget.dart';
import 'widgets/tutor_search_bar.dart';

class TutorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Theme.of(context).backgroundColor,
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            child: Column(
              children: [
                TutorsTabHeader(),
                TutorsSearchBar(),
              ],
            ),
          ),
          Expanded(child: TutorListWidget())
        ],
      ),
    );
  }
}
