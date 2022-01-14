import 'package:flutter/material.dart';
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
      body: Column(
        children: <Widget>[
          Container(
              color: Theme.of(context).backgroundColor, child: HomeTabHeader()),
          Expanded(child: BookingListWidget()),
        ],
      ),
    );
  }
}
