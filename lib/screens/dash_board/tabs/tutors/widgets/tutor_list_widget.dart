import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutors/tutors_bloc.dart';
import 'package:lettutor_app/widgets/empty_widget.dart';
import 'package:lettutor_app/widgets/error_widget.dart';
import 'tutor_item_widget.dart';

class TutorListWidget extends StatefulWidget {
  @override
  _TutorListWidgetState createState() => _TutorListWidgetState();
}

class _TutorListWidgetState extends State<TutorListWidget> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_isBottom) context.read<TutorsBloc>().add(TutorsLoadMoreEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutorsBloc, TutorsState>(
      builder: (context, state) {
        if (state is TutorsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TutorsLoadFailureState)
          return AppErrorWidget(
            retry: () {
              context
                  .read<TutorsBloc>()
                  .add(TutorsRefreshEvent(showLoading: true));
            },
          );
        if (state is TutorsLoadedState) {
          if (state.tutors.isEmpty) {
            return EmptyWidget();
          }
          return CustomScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            controller: _scrollController,
            slivers: [
              CupertinoSliverRefreshControl(onRefresh: () async {
                final _tutorsBloc = context.read<TutorsBloc>();
                _tutorsBloc.add(TutorsRefreshEvent());
                await _tutorsBloc.stream.firstWhere((element) =>
                    element is TutorsLoadedState ||
                    element is TutorsLoadFailureState);
              }),
              SliverPadding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) =>
                              TutorItemWidget(tutor: state.tutors[index]),
                          childCount: state.tutors.length))),
              SliverToBoxAdapter(
                child: state.status == TutorsStatus.loadingMore
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
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
