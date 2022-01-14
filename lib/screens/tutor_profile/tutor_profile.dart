import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutor_profile/tutor_profile_bloc.dart';

import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/screens/tutor_profile/widgets/tutor_intro_video.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/empty_widget.dart';
import 'package:lettutor_app/widgets/error_widget.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';

import 'widgets/favorite_button.dart';
import 'widgets/tutor_info.dart';
import 'widgets/tutor_reviews.dart';

class TutorProfile extends StatelessWidget {
  const TutorProfile();

  @override
  Widget build(BuildContext context) {
    _buildFlatButton({Widget icon, Function() function, String title}) {
      return TextButton(
          onPressed: function,
          child: Column(
            children: <Widget>[
              icon,
              SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Theme.of(context).primaryColor),
              )
            ],
          ));
    }

    return Scaffold(
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).profile,
        ),
        body: Container(
            height: double.infinity,
            color: Theme.of(context).backgroundColor,
            child: BlocBuilder<TutorProfileBloc, TutorProfileState>(
                builder: (context, state) {
              if (state is TutorProfileInitialState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TutorProfileLoadFailedState)
                return AppErrorWidget(
                  retry: () {
                    context
                        .read<TutorProfileBloc>()
                        .add(TutorProfileRefreshEvent());
                  },
                );
              if (state is TutorProfileLoadedState) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(children: [
                          TutorImageWidget(
                              tutorBasicInfo: state.tutor.tutorBasicInfo,
                              height: 100,
                              showRating: true),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            state.tutor.bio,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SubmitButton(
                            text: 'Book now',
                            // text: AppLocalizations.of(context).calendar,
                            backgroundColor: Theme.of(context).primaryColor,
                            function: () {
                              Navigator.of(context).pushNamed(
                                  LettutorRoutes.tutorSchedule,
                                  arguments: state.tutor);
                            },
                            textColor: Colors.white,
                            icon: Icon(Icons.calendar_today),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildFlatButton(
                                    icon: Badge(
                                      badgeColor: Colors.redAccent,
                                      badgeContent: Text(
                                        '1',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(color: Colors.white),
                                      ),
                                      child: Icon(Icons.video_library_outlined),
                                    ),
                                    function: () {
                                      showModalBottomSheet(
                                        isScrollControlled: false,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) => TutorIntroVideo(
                                            state.tutor.tutorBasicInfo.name,
                                            state.tutor.video),
                                      );
                                    },
                                    title: AppLocalizations.of(context)
                                        .introVideo),
                                FavoriteButton(state.tutor),
                                _buildFlatButton(
                                    icon: Icon(
                                      Icons.report,
                                      size: 20,
                                    ),
                                    function: () {
                                      Navigator.pushNamed(
                                          context, LettutorRoutes.tutorReport,
                                          arguments: state.tutor);
                                    },
                                    title: AppLocalizations.of(context).report),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TutorInfo(state.tutor),
                        ]),
                      ),
                      TutorReviews(state.tutor.tutorBasicInfo.feedbacks)
                    ],
                  ),
                );
              }
              return EmptyWidget();
            })));
  }
}
