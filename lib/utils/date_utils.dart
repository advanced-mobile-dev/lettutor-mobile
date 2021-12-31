import 'package:intl/intl.dart';

class MyDateUtils {
  static final outputDateFormat = DateFormat('dd/MM/yyyy');
  static final inputDateFormat = DateFormat('yyyy/MM/dd');
  static String formatDate(DateTime date) {
    String output = '';
    try {
      return outputDateFormat.format(date);
    } catch (_) {}
    return output;
  }

  static DateTime formatStringToDate(String date) {
    try {
      return inputDateFormat.parse(date);
    } catch (_) {}
    return null;
  }
}
