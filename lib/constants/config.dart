import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lettutor_app/models/config/country.dart';

class AppConfig {
  AppConfig._();

  static List<Country> _countries;
  static List<Country> get countries => _countries;

  static Future<void> readCountriesFromJson() async {
    String jsonString = await rootBundle
        .loadString('assets/jsons/countries.json')
        .catchError((error) {});
    List<Country> countries = (jsonDecode(jsonString ?? '[]') as List)
        .map((e) => Country.fromJson(e))
        .toList();
    _countries = countries;
  }
}
