abstract class Failure {
  final String message;
  
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message) : super(message);
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure(String message) : super(message);
}