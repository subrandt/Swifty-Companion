import 'package:swifty_companion/domain/entities/skill.dart';
import 'package:swifty_companion/domain/entities/project.dart';

class User {
  final String login;
  final String email;
  final String? phone;
  final double level;
  final String? location;
  final String imageUrl;
  final double? wallet;
  final List<Skill> skills;
  final List<Project> projects;

  User({
    required this.login,
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