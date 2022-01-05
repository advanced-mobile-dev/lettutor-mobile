import 'package:lettutor_app/data/network/api_service.dart';
import 'package:lettutor_app/models/tutor_schedule/booking_info.dart';

class PaymentRepository {
  Future<List<BookingInfo>> bookClass(
      String scheduleDetailid, String note) async {
    final List<BookingInfo> bookingInfo =
        await ApiService().bookClass(scheduleDetailid, note);

    return bookingInfo;
  }

  Future<double> getPriceOfSession() async {
    return await ApiService().getPriceOfSession();
  }
}
