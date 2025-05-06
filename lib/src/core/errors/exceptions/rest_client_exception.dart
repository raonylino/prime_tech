final class RestClientException implements Exception {
  final int? statusCode;
  final String? message;
  final dynamic data;

  RestClientException({this.data, this.statusCode, this.message});

  @override
  String toString() =>
      'RestClientException(statusCode: $statusCode, message: $message)';
}
