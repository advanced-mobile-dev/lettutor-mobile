import 'package:lettutor_app/config/config.dart';

class StringUtils {
  StringUtils._();

  static String getCountryNameByCode(String countryCode) {
    return AppConfig.countries
        .firstWhere((element) => element.code == countryCode)
        .name;
  }
}
