import 'package:swifty_companion/data/models/project_model.dart';
import 'package:swifty_companion/domain/entities/skill.dart';

class User {
  final String login;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final double level;
  final String? location;
  final String imageUrl;
  final double? wallet;
  final List<Skill> skills;
  final List<ProjectModel> projects;

  User({
    required this.login,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.level,
    this.location,
    required this.imageUrl,
    this.wallet,
    required this.skills,
    required this.projects,
  });
}
