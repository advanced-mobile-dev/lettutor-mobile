import 'dart:convert';
import 'package:http/http.dart';
import 'package:lettutor_app/data/network/rest_client.dart';
import 'package:lettutor_app/models/booking/booking_info.dart';

class PaymentApiClient {
  final BaseClient httpClient;
  RestClient _restClient;
  PaymentApiClient({this.httpClient}) {
    _restClient = RestClient(httpClient);
  }

  bookClass(String scheduleDetailid, String note) async {
    final String endpoint = '/booking';
    final Response response = await _restClient.post('$endpoint', body: {
      "scheduleDetailIds": [scheduleDetailid],
      "note": note
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return (body['data'] as List)
          .map((e) => BookingInfo.fromJson(e))
          .toList();
    }
    return null;
  }

  Future<double> getPriceOfSession() async {
    return 100;
  }
}
