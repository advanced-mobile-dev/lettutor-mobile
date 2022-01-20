import 'package:flutter/material.dart';
import 'package:lettutor_app/data/network/apis/payment_api_client.dart';
import 'package:lettutor_app/models/booking/booking_info.dart';

class PaymentRepository {
  final PaymentApiClient paymentApiClient;
  PaymentRepository({@required this.paymentApiClient});
  Future<List<BookingInfo>> bookClass(
      String scheduleDetailid, String note) async {
    final List<BookingInfo> bookingInfo =
        await paymentApiClient.bookClass(scheduleDetailid, note);

    return bookingInfo;
  }

  Future<double> getPriceOfSession() async {
    return await paymentApiClient.getPriceOfSession();
  }
}
