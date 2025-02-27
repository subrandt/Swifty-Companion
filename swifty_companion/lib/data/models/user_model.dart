import '../../domain/entities/user.dart';
import './skill_model.dart';
import './project_model.dart';

class CursusUser {
  final int cursusId;
  final String cursusName;
  final double level;
  final List<SkillModel> skills;

  CursusUser({
    required this.cursusId,
    required this.cursusName,
    required this.level,
    required this.skills,
  });

  factory CursusUser.fromJson(Map<String, dynamic> json) {
    List<SkillModel> skills = [];
    if (json['skills'] != null) {
      skills = (json['skills'] as List)
          .map((skill) => SkillModel.fromJson(skill))
          .toList();
    }

    return CursusUser(
      cursusId: json['cursus_id'] ?? 0,
      cursusName: json['cursus']['name'] ?? '',
      level: (json['level'] ?? 0.0).toDouble(),
      skills: skills,
    );
  }
}

class UserModel extends User {
  final List<CursusUser> cursusUsers;
  final bool isActive;

  UserModel.fromJson(Map<String, dynamic> json)
      : cursusUsers = (json['cursus_users'] as List<dynamic>?)
                ?.map((cursus) => CursusUser.fromJson(cursus))
                .toList() ??
            [],
        isActive = json['active?'] ?? false,
        super(
          login: json['login'] as String,
          firstName: json['first_name'] as String,
          lastName: json['last_name'] as String,
          email: json['email'] as String,
          phone: json['phone'] != 'hidden' ? json['phone'] as String? : null,
          level: (json['cursus_users'] as List<dynamic>?)
                  ?.firstWhere(
                    (cursus) => cursus['cursus_id'] == 21,
                    orElse: () => {'level': 0.0},
                  )['level']
                  ?.toDouble() ??
              0.0,
          location: json['location'] as String?,
          imageUrl:
              ((json['image'] as Map<String, dynamic>?)?['link'] as String?) ??
                  '',
          wallet: (json['wallet'] as num?)?.toDouble(),
          // Use the first relevant skills by default in the User model
          // We'll use getRelevantSkills() for display
          skills: []
              .map((skill) => SkillModel.fromJson(skill))
              .toList(),
          projects: (json['projects_users'] as List<dynamic>?)
                  ?.map((project) => ProjectModel.fromJson(project))
                  .toList() ??
              [],
        );

  // Get skills based on user's active status
  List<SkillModel> getRelevantSkills() {
    // If user is active, prioritize 42cursus (id: 21)
    if (isActive) {
      final mainCursusIndex = 
          cursusUsers.indexWhere((cursus) => cursus.cursusId == 21);
      
      if (mainCursusIndex >= 0 && cursusUsers[mainCursusIndex].skills.isNotEmpty) {
        return cursusUsers[mainCursusIndex].skills;
      }
    }
    
    // If user is not active or no 42cursus found, show Piscine skills (id: 9)
    final piscineIndex = 
        cursusUsers.indexWhere((cursus) => cursus.cursusId == 9);
    
    if (piscineIndex >= 0 && cursusUsers[piscineIndex].skills.isNotEmpty) {
      return cursusUsers[piscineIndex].skills;
    }
    
    // Fallback: return skills from any available cursus
    if (cursusUsers.isNotEmpty && cursusUsers[0].skills.isNotEmpty) {
      return cursusUsers[0].skills;
    }
    
    // Last resort: empty list
    return [];
  }
  
  // Get the name of the relevant cursus
  String getRelevantCursusName() {
    if (isActive) {
      // For active users, try to get 42cursus first
      final mainCursusIndex = 
          cursusUsers.indexWhere((cursus) => cursus.cursusId == 21);
      
      if (mainCursusIndex >= 0) {
        return cursusUsers[mainCursusIndex].cursusName;
      }
    }
    
    // For inactive users or if no 42cursus found, get Piscine name
    final piscineIndex = 
        cursusUsers.indexWhere((cursus) => cursus.cursusId == 9);
    
    if (piscineIndex >= 0) {
      return cursusUsers[piscineIndex].cursusName;
    }
    
    // Fallback: first available cursus name
    if (cursusUsers.isNotEmpty) {
      return cursusUsers[0].cursusName;
    }
    
    return "";
  }
}