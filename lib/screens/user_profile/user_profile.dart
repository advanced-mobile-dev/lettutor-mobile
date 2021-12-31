import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_app/blocs/authentication/authentication_bloc.dart';
import 'package:lettutor_app/config/app_sizes.dart';
import 'package:lettutor_app/config/config.dart';
import 'package:lettutor_app/models/country.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/utils/string_utils.dart';
// import 'package:lettutor_app/providers/user-provider.dart';
import 'package:lettutor_app/widgets/app_bar.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:lettutor_app/widgets/submit_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _birthdayController = new TextEditingController();
  User user;
  @override
  void initState() {
    super.initState();
    user =
        (context.read<AuthenticationBloc>().state as AuthenticatedState).user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: ApplicationAppBar(
          title: AppLocalizations.of(context).editProfile,
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                  ),
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(AppSizes.pagePadding),
                child: Column(
                  children: <Widget>[
                    _buildAvatarAndName(),
                    _buildForm(),
                  ],
                ))));
  }

  _buildAvatarAndName() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Stack(
        children: <Widget>[
          ClipOval(
            child: CachedNetworkImage(
                imageUrl: user.avatar,
                width: 75,
                height: 75,
                fit: BoxFit.fitWidth,
                errorWidget: (context, url, error) {
                  return Icon(
                    Icons.account_circle_outlined,
                    size: 75,
                  );
                }),
          ),
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

  _buildForm() {
    return Column(
      children: [
        SizedBox(height: AppSizes.verticalItemSpacing * 2),
        _buildPhoneField(),
        SizedBox(height: AppSizes.verticalItemSpacing * 2),
        _nameField(),
        SizedBox(height: AppSizes.verticalItemSpacing * 2),
        _buildBirthdayField(),
        SizedBox(height: AppSizes.verticalItemSpacing * 2),
        _buildCountryField(),
        SizedBox(height: AppSizes.verticalItemSpacing * 2),
        _levelField(),
        SizedBox(height: AppSizes.verticalItemSpacing * 2),
        _wantToLearnField(),
      ],
    );
  }

  _buildPhoneField() {
    return CustomTextField(
      initialValue: user.phone,
      title: 'Phone number',
      controller: null,
      iconData: Icons.phone,
      keyboardType: TextInputType.emailAddress,
      readOnly: user.isPhoneActivated,
    );
  }

  _nameField() {
    return CustomTextField(
      title: AppLocalizations.of(context).name,
      initialValue: user.name,
      controller: null,
      iconData: Icons.account_box,
      keyboardType: TextInputType.text,
    );
  }

  _buildBirthdayField() {
    final birthdayField = CustomTextField(
      autoFocus: false,
      title: 'Birthday',
      controller: _birthdayController,
      iconData: Icons.date_range,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) return 'Birthday is required';
        return null;
      },
      readOnly: true,
      onTap: () async {
        final DateTime date = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (date != null)
          _birthdayController.text = MyDateUtils.formatDate(date);
      },
    );

    _birthdayController.text =
        MyDateUtils.formatDate(MyDateUtils.formatStringToDate(null));
    return birthdayField;
  }

  _buildCountryField() {
    Country currentCountry = AppConfig.countries.firstWhere(
        (element) => element.code == user.country.toLowerCase(),
        orElse: () => null);
    if (currentCountry == null) {
      currentCountry = AppConfig.countries
          .firstWhere((element) => element.code == 'VN', orElse: () => null);
    }
    return DropdownButtonFormField(
      isExpanded: true,
      items: AppConfig.countries.map((e) {
        return DropdownMenuItem(
            value: e,
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  WidgetSpan(
                    child: Image.asset(
                      'assets/national_flags/${e.code.toLowerCase()}.png',
                      height: 15,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  TextSpan(
                    text: e.name,
                  )
                ],
              ),
            ));
      }).toList(),
      onChanged: (Country newValue) {
        // do other stuff with _category
        setState(() => print('${newValue.code}'));
      },
      value: currentCountry ?? null,
      decoration: InputDecoration(
        labelText: 'Country ',
        labelStyle: TextStyle(fontSize: 14),
        icon: Icon(
          Icons.flag,
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 0.5),
        ),
      ),
    );
  }

  _levelField() {
    return CustomTextField(
      title: 'My level',
      controller: null,
      iconData: Icons.book,
      keyboardType: TextInputType.text,
    );
  }

  _wantToLearnField() {
    return CustomTextField(
      title: 'Want to learn',
      controller: null,
      iconData: Icons.subject,
      keyboardType: TextInputType.text,
    );
  }
}
