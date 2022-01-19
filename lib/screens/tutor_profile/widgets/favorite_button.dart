import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/favorite_tutor/favorite_tutor_bloc.dart';
import 'package:lettutor_app/blocs/tutor_profile/tutor_profile_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';

class FavoriteButton extends StatelessWidget {
  final Tutor tutor;
  FavoriteButton(this.tutor);
  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteTutorBloc, FavoriteTutorState>(
        listener: (context, favoriteState) {
          if (favoriteState is FavoriteSuccessState) {
            context.read<TutorProfileBloc>().add(TutorProfileRefreshEvent());
          }
          if (favoriteState is FavoriteFailedState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('Something went wrong')),
              );
          }
        },
        child: TextButton(
            onPressed: () {
              context.read<FavoriteTutorBloc>().add(FavoriteTutorEvent(tutor));
            },
            child: Column(
              children: <Widget>[
                tutor.isFavorite ?? false
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border_outlined,
                      ),
                SizedBox(
                  height: 4,
                ),
                Text('${AppLocalizations.of(context).favorite}',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: tutor.isFavorite ?? false
                            ? Colors.red
                            : Theme.of(context).primaryColor))
              ],
            )));
  }
}
