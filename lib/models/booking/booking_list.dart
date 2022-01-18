import 'package:lettutor_app/models/booking/booking.dart';

class BookingList {
  final int count;
  final List<Booking> data;

  BookingList({
    this.count,
    this.data,
  });

  factory BookingList.fromJson(dynamic json) {
    List<Booking> studentBookingList = <Booking>[];
    int count = json['count'] as int;
    studentBookingList = (json['rows'] as List).map((element) {
      Booking studentSchedule = Booking.fromJson(element);
      return studentSchedule;
    }).toList();
    return BookingList(
      count: count,
      data: studentBookingList,
    );
  }
}
