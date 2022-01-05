import 'package:intl/intl.dart';
import 'package:lettutor_app/models/tutor_schedule/schedule_detail.dart';

class MyDateUtils {
  static final dateFormat = DateFormat('yyyy-MM-dd');
  static final dateFormat2 = DateFormat('dd/MM/yyyy');
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
    DateTime now = DateTime.now();
    DateTime today = new DateTime(now.year, now.month, now.day);
    if (_date.difference(today).inDays == 0)
      return 'Today, ${DateFormat('EEEE - dd/MM/yyyy').format(_date)}';
    return DateFormat('EEEE - dd/MM/yyyy').format(_date);
  }

  static String getTimeFrame(DateTime start, DateTime end) {
    return '${timeFormat.format(start)} - ${timeFormat.format(end)}';
  }

  static String getWeek(DateTime convertDate) {
    DateTime monday =
        convertDate.subtract(Duration(days: convertDate.weekday - 1));
    DateTime sunday = monday.add(Duration(days: 6));
    return 'From ${dateFormat2.format(monday)} to ${dateFormat2.format(sunday)}';
  }

  static String getBookingTime(ScheduleDetail scheduleDetail) {
    String timeFrame =
        getTimeFrame(scheduleDetail.startPeriod, scheduleDetail.endPeriod);
    return '$timeFrame \n${DateFormat('EEEE, dd/MM/yyyy').format(scheduleDetail.startPeriod)}';
  }

  static bool isToday(DateTime convertDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return convertDate == today;
  }
}
