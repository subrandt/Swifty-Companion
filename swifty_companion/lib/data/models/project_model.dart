import '/../../domain/entities/project.dart';

class ProjectModel extends Project {
  ProjectModel.fromJson(Map<String, dynamic> json) : super(
    name: json['project']['name'] ?? '',
    validated: json['validated?'] ?? false,
    finalMark: (json['final_mark'] as num?)?.toDouble(),
    status: json['status'] ?? 'unavailable',
  );
}