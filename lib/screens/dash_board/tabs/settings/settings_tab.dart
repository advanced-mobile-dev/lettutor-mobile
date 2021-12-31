import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_app/blocs/app_settings/app_settings_bloc.dart';
import 'package:lettutor_app/blocs/authentication/authentication_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/routes.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: AppSizes.hugeTextSize);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(AppLocalizations.of(context).settings, style: titleStyle),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (!(state is AuthenticatedState)) return SizedBox();
                final currentState = (state as AuthenticatedState);
                return Row(
                  children: <Widget>[
                    currentState.user.avatar == null
                        ? Icon(
                            Icons.account_circle_outlined,
                            size: 60,
                          )
                        : ClipOval(
                            child: CachedNetworkImage(
                                imageUrl: currentState.user.avatar,
                                width: 60,
                                height: 60,
                                fit: BoxFit.fitWidth,
                                errorWidget: (context, url, error) {
                                  return Icon(
                                    Icons.account_circle_outlined,
                                    size: 60,
                                  );
                                }),
                          ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentState.user.name,
                            style: TextStyle(
                                fontSize: AppSizes.normalTextSize,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(currentState.user.email,
                            style: TextStyle(
                                fontSize: AppSizes.normalTextSize,
                                fontWeight: FontWeight.normal))
                      ],
                    )
                  ],
                );
              },
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
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: AppSizes.verticalItemSpacing,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(AppLocalizations.of(context).accountSettings,
                        style: TextStyle(
                            fontSize: AppSizes.normalTextSize,
                            color: Colors.grey)),
                  ),
                  SizedBox(
                    height: AppSizes.verticalItemSpacing,
                  ),
                  SettingItem(
                    title: AppLocalizations.of(context).editProfile,
                    function: () {
                      Navigator.of(context)
                          .pushNamed(LettutorRoutes.userProfile);
                    },
                  ),
                  SettingItem(
                    title: AppLocalizations.of(context).changePassword,
                    function: () {
                      Navigator.of(context)
                          .pushNamed(LettutorRoutes.changePassword);
                    },
                  ),
                  SettingItem(
                    title: AppLocalizations.of(context).language,
                    function: () {
                      Navigator.of(context)
                          .pushNamed(LettutorRoutes.languageSetting);
                    },
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).darkMode,
                          style: TextStyle(
                              fontSize: AppSizes.normalTextSize,
                              fontWeight: FontWeight.normal),
                        ),
                        BlocBuilder<AppSettingsBloc, AppSettingsState>(
                            builder: (context, state) => Switch(
                                  value: state.isDarkTheme,
                                  onChanged: (bool value) {
                                    context.read<AppSettingsBloc>().add(
                                        ThemeChangedEvent(isDarkTheme: value));
                                  },
                                ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppSizes.verticalItemSpacing,
            ),
            SubmitButton(
                text: AppLocalizations.of(context).logout,
                function: () {
                  context.read<AuthenticationBloc>().add(LogoutEvent());
                }),
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final Function() function;
  final String title;
  SettingItem({@required this.function, @required this.title});

  final TextStyle textStyle = TextStyle(
      fontSize: AppSizes.normalTextSize, fontWeight: FontWeight.normal);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: function,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: textStyle,
              ),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ));
  }
}
