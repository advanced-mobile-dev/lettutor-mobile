import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/blocs/user_profile/user_profile_bloc.dart';

import 'package:lettutor_app/screens/user_profile/widgets/user_info_form.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/widgets/loading_overlay.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  LoadingOverlay _loadingOverlay;
  @override
  void initState() {
    super.initState();
    _loadingOverlay = LoadingOverlay();
    context.read<UserProfileBloc>().add(FetchUserInfodEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).editProfile,
        ),
        body: BlocConsumer<UserProfileBloc, UserProfileState>(
          listener: (BuildContext context, state) {
            if (state is LoadedState) {
              if (state.userInfoStatus == UserInfoStatus.saving) {
                _loadingOverlay.show(context);
              } else {
                _loadingOverlay.hide();
              }
              if (state.userInfoStatus == UserInfoStatus.failed) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('Failed to save changes')),
                  );
              }
              if (state.userInfoStatus == UserInfoStatus.success) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text('Successfully saved')),
                  );
              }
            }
          },
          builder: (context, state) {
            if (state is InitialState)
              return Center(child: CircularProgressIndicator());
            if (state is LoadedState)
              return SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.all(15),
                child: UserInfoForm(state.user),
              ));
            return SizedBox();
          },
        ));
  }
}
