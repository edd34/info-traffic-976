class HTTPResponse<T> {
  HTTPResponse({
    required this.isSuccessful,
    required this.data,
    required this.message,
    required this.statusCode,
  });
  bool isSuccessful;
  T data;
  int statusCode;
  String message;
}
