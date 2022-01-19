import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:lettutor_app/blocs/student_booking/student_booking_bloc.dart';
import 'package:lettutor_app/models/booking/booking.dart';
import 'package:lettutor_app/widgets/empty_widget.dart';
import 'package:lettutor_app/widgets/error_widget.dart';
import 'booking_item_widget.dart';
import 'upcomming_class_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookingListWidget extends StatefulWidget {
  @override
  State<BookingListWidget> createState() => _BookingListWidgetState();
}

class _BookingListWidgetState extends State<BookingListWidget> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    context.read<StudentBookingBloc>().add(StudentBookingRefreshEvent());
    _scrollController.addListener(() {
      if (_isBottom)
        context.read<StudentBookingBloc>().add(StudentBookingLoadMoreEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBookingBloc, StudentBookingState>(
      builder: (context, state) {
        if (state is StudentBookingLoadingState)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is StudentBookingLoadFailureState) {
          return AppErrorWidget(
            retry: () {
              context
                  .read<StudentBookingBloc>()
                  .add(StudentBookingRefreshEvent());
            },
          );
        }
        if (state is StudentBookingLoadedState) {
          if (state.bookingList.length == 0)
            return EmptyWidget(
                content: 'You have no upcoming lesson, click below to book',
                action: () {
                  context
                      .read<BottomNavBloc>()
                      .add(TabChangeEvent(AppTab.tutors.index));
                });
          Booking upcommingClass = state.bookingList[0];
          return CustomScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            controller: _scrollController,
            slivers: [
              CupertinoSliverRefreshControl(onRefresh: () async {
                context
                    .read<StudentBookingBloc>()
                    .add(StudentBookingRefreshEvent());
                await context.read<StudentBookingBloc>().stream.firstWhere(
                    (element) =>
                        element is StudentBookingLoadedState ||
                        element is StudentBookingLoadFailureState);
              }),
              SliverToBoxAdapter(
                child: UpcommingClassWidget(upcommingClass),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      // color: Theme.of(context).primaryColor.withOpacity(0.1),
                      ),
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${AppLocalizations.of(context).others}',
                        // 'Others',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => index == 0
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: BookingItemWidget(
                                studentBooking: state.bookingList[index],
                              ),
                            ),
                      childCount: state.bookingList.length)),
              SliverToBoxAdapter(
                child: (state.status == SBListStatus.loadingMore)
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
