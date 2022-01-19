import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_app/blocs/lesson_time_bloc/lesson_time_bloc.dart';

import 'package:lettutor_app/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTabHeader extends StatelessWidget {
  const HomeTabHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, bottom: 24),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/icons/logo.svg',
                  color: Theme.of(context).primaryColor),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LettutorRoutes.history);
                },
                child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Icon(
                    Icons.history,
                    size: 24,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    AppLocalizations.of(context).history,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).iconTheme.color,
                        ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<LessonTimeBloc, LessonTimeState>(
              builder: (context, state) {
            if (state is LessonTimeLoadedState &&
                state.learnedTime.inSeconds > 0)
              return Container(
                  alignment: Alignment.centerLeft,
                  child: Row(children: [
                    Text(
                      '${AppLocalizations.of(context).totalLessonTime}: ${state.learnedTime.inHours} ${AppLocalizations.of(context).hours} ${state.learnedTime.inMinutes.remainder(60)} ${AppLocalizations.of(context).minutes}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 15),
                    ),
                  ]));
            return Text(
              '${AppLocalizations.of(context).welcomeToLettutor}',
              // 'Welcome to lettutor',
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15),
            );
          })
        ],
      ),
    );
  }
}
