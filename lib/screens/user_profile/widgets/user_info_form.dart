import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_app/blocs/user_profile/user_profile_bloc.dart';
import 'package:lettutor_app/constants/config.dart';
import 'package:lettutor_app/models/config/country.dart';
import 'package:lettutor_app/models/config/level.dart';
import 'package:lettutor_app/models/user/user.dart';
import 'package:lettutor_app/screens/user_profile/widgets/profile_header.dart';
import 'package:lettutor_app/utils/date_utils.dart';
import 'package:lettutor_app/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor_app/widgets/submit_button.dart';

import 'country_picker.dart';

class UserInfoForm extends StatefulWidget {
  final User user;
  UserInfoForm(this.user);
  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  TextEditingController _birthdayController = new TextEditingController();
  TextEditingController _countryController = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name, _phone;
  Level _level;
  String _birthDay;
  Country _country;
  XFile _pickedFile;

  @override
  void initState() {
    super.initState();
    _birthdayController.text = widget.user.birthday ?? '';
    _country = AppConfig.countries.firstWhere(
        (element) => element.code == widget.user.country,
        orElse: () => null);
    _countryController.text = _country != null ? _country.name : '';
  }

  @override
  Widget build(BuildContext context) {
    const _spacing = const SizedBox(height: 15);
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (!(state is LoadedState)) return SizedBox();
        final user = (state as LoadedState).user;
        return Form(
          key: _formKey,
          child: Column(
            children: [
              UserProfileHeader(
                user: user,
                onPickedImage: (pickedImage) {
                  _pickedFile = pickedImage;
                },
              ),
              _spacing,
              CustomTextField(
                initialValue: user.phone,
                title: 'Phone number',
                controller: null,
                iconData: Icons.phone,
                onSaved: (value) => _phone = value,
                keyboardType: TextInputType.emailAddress,
                readOnly: user.isPhoneActivated,
              ),
              _spacing,
              CustomTextField(
                title: AppLocalizations.of(context).name,
                initialValue: user.name,
                controller: null,
                onSaved: (name) => _name = name,
                iconData: Icons.account_box,
                keyboardType: TextInputType.text,
              ),
              _spacing,
              _buildBirthdayField(user),
              _spacing,
              _buildCountryField(user),
              _spacing,
              _levelField(user),
              const SizedBox(
                height: 30,
              ),
              SubmitButton(
                function: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    context.read<UserProfileBloc>().add(SavePressedEvent(
                        user.copyWith(
                          name: _name,
                          phone: _phone,
                          birthday: _birthDay,
                          country: _country.code.toUpperCase(),
                          level: _level.code,
                        ),
                        avatar: _pickedFile));
                  }
                },
                text: '${AppLocalizations.of(context).save}',
              )
            ],
          ),
        );
      },
    );
  }

  _buildBirthdayField(User user) {
    print(user.birthday);
    return CustomTextField(
      autoFocus: false,
      onSaved: (value) => {_birthDay = value},
      title: 'Birthday',
      controller: _birthdayController,
      iconData: Icons.date_range,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) return 'Birthday is required';
        if (MyDateUtils.formatStringToDate(value) == null)
          return 'Invalid date';
        return null;
      },
      readOnly: true,
      onTap: () async {
        final DateTime date = await showDatePicker(
          context: context,
          initialDate:
              MyDateUtils.formatStringToDate(_birthDay) ?? DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          _birthdayController.text = MyDateUtils.formatDate(date);
        }
      },
    );
  }

  _buildCountryField(User user) {
    return CustomTextField(
      autoFocus: false,
      title: 'Country',
      controller: _countryController,
      iconData: Icons.language,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) return 'Country is required';

        return null;
      },
      readOnly: true,
      onTap: () async {
        final String countryCode = await showSearch(
          context: context,
          delegate: CountryPicker(),
        );
        if (countryCode != null && countryCode.isNotEmpty) {
          final selectedCountry = AppConfig.countries.firstWhere(
              (element) => element.code == countryCode,
              orElse: () => null);
          _country = selectedCountry;
          _countryController.text = selectedCountry.name ?? '';
        }
      },
    );
  }

  _levelField(User user) {
    _level = Level.data.firstWhere(
      (element) => element.code == user.level,
      orElse: () => Level.data[0],
    );
    print(_level);
    return DropdownButtonFormField(
        isExpanded: true,
        items: Level.data.map((e) {
          return DropdownMenuItem(value: e, child: Text(e.name));
        }).toList(),
        onChanged: (Level newValue) {
          setState(() => _level = newValue);
        },
        onSaved: (value) => {_level = value},
        value: _level,
        decoration: InputDecoration(
          label: Text('Level'),
          icon: Icon(Icons.book),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 0.5),
          ),
        ));
  }
}
