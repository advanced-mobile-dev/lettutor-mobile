import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/favorite_list/favorite_list_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/routes.dart';
import 'package:lettutor_app/models/speciality.dart';
import 'package:lettutor_app/models/tutor/tutor.dart';
import 'package:lettutor_app/widgets/tutor_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteItemWidget extends StatelessWidget {
  final Tutor tutor;

  FavoriteItemWidget({this.tutor});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, LettutorRoutes.tutorProfile,
            arguments: tutor);
        context.read<FavoriteListBloc>().add(FavoriteListFetchEvent());
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(1, 3))
            ]),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          children: <Widget>[
            TutorImageWidget(
                tutorBasicInfo: tutor.tutorBasicInfo,
                height: 60,
                showRating: false),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            Container(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  ...tutor.specialties
                      .split(',')
                      .map((e) => Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 1))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              Speciality.data
                                  .firstWhere((element) => element.code == e)
                                  .name,
                              style: TextStyle(
                                  color: Colors.blueGrey[700],
                                  fontSize: AppSizes.smallTextSize),
                            ),
                          ))
                      .toList()
                ],
              ),
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing / 2,
            ),
            Container(
              width: double.infinity,
              child: Text(tutor.bio,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.black, fontSize: AppSizes.smallTextSize)),
            ),
          ],
        ),
      ),
    );
  }
}
