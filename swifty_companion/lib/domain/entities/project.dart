class Project {
  final String name;
  final String status; // "completed", "failed", "in_progress"
  final double? finalMark;
  final String? validatedAt;

  Project({
    required this.name,
    required this.status,
    this.finalMark,
    this.validatedAt,
  });
}