import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/tutors/tutors_bloc.dart';
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
    context.read<TutorsBloc>().add(TutorsFetchEvent());

    _scrollController.addListener(() {
      if (_isBottom) context.read<TutorsBloc>().add(TutorsLoadMoreEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return BlocBuilder<TutorsBloc, TutorsState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is LoadFailureState)
          return const Center(child: Text('failed to fetch tutors'));
        if (state is LoadSuccessState) {
          if (state.tutors.isEmpty) {
            return const Center(child: Text('not found tutors'));
          }
          return ListView.builder(
            itemCount: state.hasReachedMax
                ? state.tutors.length
                : state.tutors.length + 1,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              if (index < state.tutors.length)
                return TutorItemWidget(tutor: state.tutors[index]);
              else
                return Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(),
                  ),
                );
            },
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
