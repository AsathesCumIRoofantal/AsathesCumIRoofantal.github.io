class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final dynamic error;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
  });

  factory ApiResponse.success(T? data, {String? message}) {
    return ApiResponse(success: true, data: data, message: message);
  }

  factory ApiResponse.failure(String message, {dynamic error}) {
    return ApiResponse(success: false, message: message, error: error);
  }
}
