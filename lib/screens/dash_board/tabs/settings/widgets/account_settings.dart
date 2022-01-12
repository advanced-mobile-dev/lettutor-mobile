import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/widgets/network_circle_avatar.dart';
import 'setting_item.dart';

class AccountSettings extends StatefulWidget {
  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _user = context.read<UserRepository>().user;

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: AppSizes.verticalItemSpacing,
          ),
          _user == null
              ? SizedBox()
              : Row(
                  children: <Widget>[
                    NetworkCircleAvatar(url: _user.avatar, radius: 30),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_user.name,
                            style: TextStyle(
                                fontSize: AppSizes.normalTextSize,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(_user.email,
                            style: TextStyle(
                                fontSize: AppSizes.normalTextSize,
                                fontWeight: FontWeight.normal))
                      ],
                    )
                  ],
                ),
          SizedBox(
            height: AppSizes.verticalItemSpacing,
          ),
          Divider(
            thickness: 1.5,
          ),
          SizedBox(
            height: AppSizes.verticalItemSpacing,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text('Account settings',
                style: TextStyle(
                    fontSize: AppSizes.smallTextSize, color: Colors.grey[600])),
          ),
          SizedBox(
            height: 10,
          ),
          SettingItem(
            title: 'Become a tutor',
            function: () {
              Navigator.of(context).pushNamed(LettutorRoutes.favoriteTutors);
            },
          ),
          SettingItem(
            title: 'Favorite tutors',
            function: () {
              Navigator.of(context).pushNamed(LettutorRoutes.favoriteTutors);
            },
          ),
          SettingItem(
            title: 'Edit profile',
            function: () async {
              await Navigator.of(context).pushNamed(LettutorRoutes.userProfile);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
