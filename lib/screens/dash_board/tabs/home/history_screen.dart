import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/booking_history/booking_history_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/student_booking/student_booking.dart';
import 'package:lettutor_app/models/tutor/tutor_basic_info.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/widgets/outline_button.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

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
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BookingHistoryBloc>().add(BookingHistoryRefreshEvent());
        },
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              child: BlocBuilder<BookingHistoryBloc, BookingHistoryState>(
                builder: (context, state) {
                  if (state is BookingHistoryLoadingState)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (state is BookingHistoryLoadFailureState) {
                    return Center(
                      child: Text('Failed'),
                    );
                  }
                  if (state is BookingHistoryLoadedState) {
                    if (state.bookingList.length == 0)
                      return Center(
                        child: Text('Empty'),
                      );
                    return Column(
                      children: <Widget>[
                        ...state.bookingList
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: HistoryItem(
                                  studentBooking: e,
                                ),
                              ),
                            )
                            .toList(),
                        (state.status == BookingHistoryStatus.loadingMore)
                            ? CircularProgressIndicator()
                            : SizedBox()
                      ],
                    );
                  }
                  return SizedBox();
                },
              )),
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

class HistoryItem extends StatelessWidget {
  final StudentBooking studentBooking;
  HistoryItem({@required this.studentBooking});
  @override
  Widget build(BuildContext context) {
    _buildDataRow({String title, IconData iconData, String content}) {
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              iconData,
              size: 15,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              width: 75,
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.smallTextSize,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: AppSizes.smallTextSize,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      );
    }

    TutorBasicInfo tutorBasicInfo =
        studentBooking.scheduleDetail.tutorBasicInfo;

    String feedback = studentBooking.bookingInfo.tutorReview;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3))
          ]),
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TutorImageWidget(
                        tutorBasicInfo: tutorBasicInfo,
                        size: 50,
                        showRating: false),
                  ),
                  Container(
                    child: Text(
                        '${MyDateUtils.getCommentTime(studentBooking.scheduleDetail.endPeriod)}',
                        style: TextStyle(
                            fontSize: AppSizes.smallTextSize,
                            color: Colors.grey)),
                    alignment: Alignment.topRight,
                  )
                ],
              )),
          _buildDataRow(
            title: 'Date',
            iconData: Icons.calendar_today,
            content:
                '${MyDateUtils.getBookingTime(studentBooking.scheduleDetail)}',
          ),
          _buildDataRow(
            title: 'Feedback',
            iconData: Icons.chat,
            content: '${feedback ?? ''}',
          ),
          studentBooking.bookingInfo.scoreByTutor != null
              ? _buildDataRow(
                  title: 'Mark',
                  iconData: Icons.reviews_outlined,
                  content: '${studentBooking.bookingInfo.scoreByTutor}',
                )
              : SizedBox(),
          studentBooking.bookingInfo.recordUrl != null
              ? Container(
                  padding: EdgeInsets.only(top: 20),
                  alignment: Alignment.bottomRight,
                  child: CustomTextButton(
                      text: 'Record',
                      function: () {},
                      iconData: Icons.video_call,
                      color: Theme.of(context).primaryColor),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
