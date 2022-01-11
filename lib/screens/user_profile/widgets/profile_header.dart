import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/widgets/app_circle_avatar.dart';

class UserProfileHeader extends StatelessWidget {
  final User user;
  UserProfileHeader(this.user);
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Stack(
        children: <Widget>[
          NetworkCircleAvatar(url: user.avatar, radius: 30),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.edit,
                  size: 15,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ))
        ],
      ),
      SizedBox(
        width: 15,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.name,
              style: TextStyle(
                  fontSize: AppSizes.normalTextSize,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 5,
          ),
          Text(user.email,
              style: TextStyle(
                  fontSize: AppSizes.normalTextSize,
                  fontWeight: FontWeight.normal))
        ],
      )
    ]);
  }
}
