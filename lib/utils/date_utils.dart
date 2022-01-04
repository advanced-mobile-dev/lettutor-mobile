import 'package:intl/intl.dart';

class MyDateUtils {
  static final dateFormat = DateFormat('yyyy-MM-dd');
  static String formatDate(DateTime date) {
    String output = '';
    try {
      return dateFormat.format(date);
    } catch (_) {}
    return output;
  }

  static DateTime formatStringToDate(String date) {
    try {
      return dateFormat.parse(date);
    } catch (err) {
      print(err);
    }
    return null;
  }
}
