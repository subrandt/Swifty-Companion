import '../../domain/entities/skill.dart';

class SkillModel extends Skill {
  SkillModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'] ?? 0,
          name: json['name'] ?? '',
          level: json['level'] ?? 0.0,
        );
}
