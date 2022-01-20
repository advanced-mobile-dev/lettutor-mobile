import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:lettutor_app/screens/favorite_list/widgets/favorite_item.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/empty_widget.dart';
import 'package:lettutor_app/widgets/error_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteTutorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationAppBar(
        title: '${AppLocalizations.of(context).favoriteTutors}',
      ),
      body: BlocBuilder<FavoriteListBloc, FavoriteListState>(
        builder: (context, state) {
          if (state is FavoriteListLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavoriteListLoadFailed) {
            return AppErrorWidget(retry: () {
              context.read<FavoriteListBloc>().add(FavoriteListFetchEvent());
            });
          }
          if (state is FavoriteListLoaded) {
            if (state.favoriteList.isEmpty) return EmptyWidget();
            // return Container(
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 1000,
            //       ),
            //       Container(
            //         width: 2000,
            //       ),
            //     ],
            //   ),
            // );
            return ListView(
                children: state.favoriteList
                    .map((e) => FavoriteItemWidget(
                          tutor: e,
                        ))
                    .toList());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
