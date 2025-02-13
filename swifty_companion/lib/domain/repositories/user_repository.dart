import 'package:swifty_companion/core/errors/exceptions.dart';
import 'package:swifty_companion/core/network/api_client.dart';
import 'package:swifty_companion/data/models/user_model.dart';
import 'package:swifty_companion/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUser(String login);
}

class UserRepositoryImpl implements UserRepository {
  final ApiClient apiClient;

  UserRepositoryImpl(this.apiClient);

  @override
  Future<User> getUser(String login) async {
    try {
      final userData = await apiClient.searchUser(login);
      return UserModel.fromJson(userData);
    } catch (e) {
      throw UserException('Failed to fetch user data: $e');
    }
  }
}
