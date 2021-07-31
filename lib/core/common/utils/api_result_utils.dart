abstract class ApiResult {
  dynamic data;
  late String message;
  late String errorMessage;
}

class SuccessData implements ApiResult {
  @override
  dynamic data;

  @override
  String errorMessage;

  @override
  late String message;

  SuccessData({
    required this.data,
  }) : errorMessage = "";
}

class ErrorData implements ApiResult {
  @override
  dynamic data;

  @override
  String errorMessage;

  @override
  String message;

  ErrorData({
    required this.data,
    required this.errorMessage,
  }) : message = "";
}
