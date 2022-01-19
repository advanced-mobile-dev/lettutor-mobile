import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/courses/courses_bloc.dart';
import 'package:lettutor_app/widgets/empty_widget.dart';
import 'package:lettutor_app/widgets/error_widget.dart';

import 'course_item_widget.dart';

class CourseListWidget extends StatefulWidget {
  @override
  State<CourseListWidget> createState() => _CourseListWidgetState();
}

class _CourseListWidgetState extends State<CourseListWidget> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_isBottom) {
        context.read<CoursesBloc>().add(CoursesLoadMoreEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesBloc, CoursesState>(builder: (context, state) {
      if (state is CoursesLoadingState)
        return Center(
          child: CircularProgressIndicator(),
        );
      if (state is CoursesLoadFailureState)
        return AppErrorWidget(
          retry: () {
            context.read<CoursesBloc>()
              ..add(CoursesRefreshEvent(showLoading: true));
          },
        );
      if (state is CoursesLoadedState) {
        if (state.courses.isEmpty) return EmptyWidget();
        final _widthScreen = MediaQuery.of(context).size.width;
        return CustomScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          controller: _scrollController,
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: () async {
              final _coursesBloc = context.read<CoursesBloc>();
              _coursesBloc.add(CoursesRefreshEvent());
              await _coursesBloc.stream.firstWhere((element) =>
                  element is CoursesLoadedState ||
                  element is CoursesLoadFailureState);
              context.read<CoursesBloc>()..add(CoursesRefreshEvent());
            }),
            SliverPadding(
              padding: EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 5),
              sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: _widthScreen / 2 + 30,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          CourseItemWidget(course: state.courses[index]),
                      childCount: state.courses.length)),
            ),
            SliverToBoxAdapter(
              child: state.status == CoursesStatus.loadingMore
                  ? Container(
                      padding: EdgeInsets.only(bottom: 12),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox(),
            )
          ],
        );
      }
      return SizedBox();
    });
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
