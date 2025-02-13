import '../../domain/entities/user.dart';
import './skill_model.dart';
import './project_model.dart';

class UserModel extends User {
  UserModel.fromJson(Map<String, dynamic> json)
      : super(
          login: json['login'] as String,
          email: json['email'] as String,
          phone: json['phone'] != 'hidden' ? json['phone'] as String? : null,
          level: (json['cursus_users'] as List<dynamic>?)
                  ?.firstWhere((cursus) => cursus['cursus_id'] == 21,
                      orElse: () => {'level': 0.0})['level']
                  ?.toDouble() ??
              0.0,
          location: json['location'] as String?,
          imageUrl:
              ((json['image'] as Map<String, dynamic>?)?['link'] as String?) ??
                  '',
          wallet: (json['wallet'] as num?)?.toDouble(),
          skills: (json['cursus_users'] as List<dynamic>?)
                  ?.expand((cursus) => ((cursus['skills'] ?? []) as List)
                      .map((skill) => SkillModel.fromJson(skill)))
                  .toList() ??
              [],
          projects: (json['projects_users'] as List<dynamic>?)
                  ?.map((project) => ProjectModel.fromJson(project))
                  .toList() ??
              [],
        );
}
