import 'package:intl/intl.dart';

class MyDateUtils {
  static final dateFormat = DateFormat('yyyy-MM-dd');
  static final timeFormat = DateFormat.Hm();
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

  static String getScheduleDateString(String date) {
    DateTime _date = formatStringToDate(date);
    return dateFormat.format(_date);
    return DateFormat.yMMMMEEEEd().format(_date);
  }

  static String getTimeFrame(DateTime start, DateTime end) {
    return '${timeFormat.format(start)} - ${timeFormat.format(end)}';
  }
}
