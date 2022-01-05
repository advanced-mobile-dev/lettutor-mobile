import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/student_schedule/student_schedule_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/home_tab_header.dart';
import 'widgets/schedule_list.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_isBottom) context.read<StudentScheduleBloc>().add(LoadMoreEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            HomeHeader(),
            ScheduleList(),
          ],
        ),
      ),
    );
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
