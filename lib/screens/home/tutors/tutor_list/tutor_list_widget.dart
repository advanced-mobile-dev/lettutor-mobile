import 'package:flutter/material.dart';
import 'package:lettutor_app/providers/tutor-provider.dart';
import 'package:provider/provider.dart';

import 'tutor_item_widget.dart';

class TutorListWidget extends StatefulWidget {
  @override
  _TutorListWidgetState createState() => _TutorListWidgetState();
}

class _TutorListWidgetState extends State<TutorListWidget> {
  loadData() async {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      await context.read<TutorProvider>().searchTutors(page: 1, speciality: '');
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TutorProvider>(builder: (context, value, child) {
      if (value.loading)
        return Center(
          child: CircularProgressIndicator(),
        );
      return Column(children: [
        for (var element in value.tutorList) ...[
          TutorItemWidget(tutor: element),
          SizedBox(
            height: 15,
          )
        ],
      ]);
    });
  }
}
