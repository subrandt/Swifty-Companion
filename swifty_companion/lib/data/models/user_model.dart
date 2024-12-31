import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel.fromJson(Map<String, dynamic> json) : super(
    login: json['login'],
    email: json['email'],
    phone: json['phone'],
    level: json['level'],
    location: json['location'],
    imageUrl: json['imageUrl'],
    wallet: json['wallet'],
    skills: json['skills'],
    projects: json['projects'],
  );
}