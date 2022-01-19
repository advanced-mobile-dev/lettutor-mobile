import 'package:intl/intl.dart';
import 'package:lettutor_app/models/schedule/schedule_detail.dart';

class MyDateUtils {
  static final dateFormat = DateFormat('yyyy-MM-dd');
  static final dateFormat2 = DateFormat('dd/MM/yyyy');
  static final dateFormat3 = DateFormat('EEEE - dd/MM/yyyy');
  static final timeFormat = DateFormat.Hm();
  static String formatDate(DateTime date) {
    String output = '';
    try {
      return dateFormat.format(date);
    } catch (_) {}
    return output;
  }

  static String formatDate2(DateTime date) {
    String output = '';
    try {
      return dateFormat2.format(date);
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
      return 'Today, ${dateFormat3.format(_date)}';
    return dateFormat3.format(_date);
  }

  static String getTimeFrame(DateTime start, DateTime end) {
    return '${timeFormat.format(start)} - ${timeFormat.format(end)}';
  }

  static String getTime(DateTime start) {
    return '${timeFormat.format(start)} - ${dateFormat2.format(start)}';
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

  static timeRemaining(DateTime startPeriod, {bool showSeconds = false}) {
    final duration = startPeriod.difference(DateTime.now());
    if (duration.inSeconds < 0) return '0h:0p';
    if (duration.inHours < 24) {
      return "${duration.inHours}h:${duration.inMinutes.remainder(60)}m${showSeconds ? ':${duration.inSeconds.remainder(60)}s' : ''}";
    } else {
      return "${duration.inDays} days, ${duration.inHours.remainder(24)}h:${duration.inMinutes.remainder(60)}m${showSeconds ? ':${duration.inSeconds.remainder(60)}s' : ''}";
    }
  }

  static getCommentTime(DateTime endPeriod) {
    final duration = DateTime.now().difference(endPeriod);
    if (duration.inHours < 24) {
      if (duration.inHours == 0) return '${duration.inMinutes} minutes ago';
      return '${duration.inHours} hours ago';
    }
    return '${duration.inDays} days ago';
  }

  static getTimeDuration(DateTime startPeriod, DateTime endPeriod) {
    final duration = endPeriod.difference(startPeriod);
    return '${duration.inMinutes}';
  }
}
