import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/student_booking/student_booking_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/home_tab_header.dart';
import 'widgets/booking_list_widget.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          HomeTabHeader(),
          Expanded(child: BookingListWidget()),
        ],
      ),
    );
  }
}
