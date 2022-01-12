import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:lettutor_app/screens/favorite_list/widgets/favorite_item.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/error_widget.dart';

class FavoriteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationAppBar(
        title: 'Favorite tutors',
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
