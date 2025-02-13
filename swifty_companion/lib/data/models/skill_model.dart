import '../../domain/entities/skill.dart';

class SkillModel extends Skill {
  SkillModel.fromJson(Map<String, dynamic> json) : super(
    name: json['name'] ?? '',
    level: (json['level'] as num?)?.toDouble() ?? 0.0,
    percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
  );
}