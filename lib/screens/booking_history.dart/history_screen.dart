import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/booking_history/booking_history_bloc.dart';
import 'package:lettutor_app/blocs/user_profile/user_profile_bloc.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/widgets/empty_widget.dart';
import 'package:lettutor_app/widgets/error_widget.dart';

import 'widgets/history_item_widget.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_isBottom) {
        context.read<BookingHistoryBloc>().add(BookingHistoryLoadMoreEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).history,
        ),
        body: BlocBuilder<BookingHistoryBloc, BookingHistoryState>(
          builder: (context, state) {
            if (state is BookingHistoryLoadingState)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (state is BookingHistoryLoadFailureState) {
              return AppErrorWidget(
                retry: () {
                  context
                      .read<BookingHistoryBloc>()
                      .add(BookingHistoryRefreshEvent());
                },
              );
            }
            if (state is BookingHistoryLoadedState) {
              if (state.bookingList.length == 0) return EmptyWidget();

              return CustomScrollView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  slivers: [
                    CupertinoSliverRefreshControl(
                      onRefresh: () async {
                        final _bookingHistoryBloc =
                            context.read<BookingHistoryBloc>();
                        _bookingHistoryBloc.add(BookingHistoryRefreshEvent());
                        await _bookingHistoryBloc.stream.firstWhere((element) =>
                            element is BookingHistoryLoadedState ||
                            element is BookingHistoryLoadFailureState);
                      },
                    ),
                    SliverPadding(
                        padding: EdgeInsets.only(top: 10),
                        sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: HistoryItem(
                                        studentBooking:
                                            state.bookingList[index],
                                      ),
                                    ),
                                childCount: state.bookingList.length))),
                    SliverToBoxAdapter(
                        child: state.status == BookingHistoryStatus.loadingMore
                            ? Container(
                                padding: EdgeInsets.only(bottom: 12),
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox())
                  ]);
            }
            return EmptyWidget();
          },
        ));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
