class ApiException implements Exception {
  final int statusCode;

  final String message;

  ApiException(this.message, this.statusCode);
}

// class FetchDataException extends ApiException {
//   FetchDataException(message, statusCode) : super(message, statusCode);
// }

// class BadRequestException extends ApiException {
//   BadRequestException(message, statusCode) : super(message, statusCode);
// }

// class UnauthorisedException extends ApiException {
//   UnauthorisedException(message, statusCode) : super(message, statusCode);
// }
