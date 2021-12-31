import 'package:flutter/material.dart';
import 'package:lettutor_app/config/app_sizes.dart';
// import 'package:lettutor_app/providers/user-provider.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final userProvider = context.read<UserProvider>().user;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: ApplicationAppBar(
        title: AppLocalizations.of(context).editProfile,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSizes.pagePadding),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        'Tutor.data3.avatar',
                        width: 125,
                      ),
                    ),
                    Positioned(
                        top: 15,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.edit,
                            size: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: AppSizes.verticalItemSpacing * 3),
              CustomTextField(
                title: AppLocalizations.of(context).name,
                initialValue: 'userProvider.name',
                controller: null,
                iconData: Icons.account_box,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: AppSizes.verticalItemSpacing * 3),
              CustomTextField(
                initialValue: 'userProvider.email',
                title: AppLocalizations.of(context).email,
                controller: null,
                iconData: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: AppSizes.verticalItemSpacing * 5,
              ),
              Container(
                  child: SubmitButton(
                      text: AppLocalizations.of(context).save, function: () {}))
            ],
          ),
        ),
      ),
    );
  }
}
