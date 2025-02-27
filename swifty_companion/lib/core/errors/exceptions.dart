class UserException implements Exception {
  final String message;

  UserException(this.message);

  @override
  String toString() {
    return 'UserException: $message';
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);

  @override
  String toString() {
    return 'NetworkException: $message';
  }
}

class ApiError implements Exception {
  final String message;

  ApiError(this.message);

  @override
  String toString() {
    return 'ApiError: $message';
  }
}
