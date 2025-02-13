class Project {
  final String name;
  final bool validated;
  final double? finalMark;
  final String status;

  Project({
    required this.name,
    required this.validated,
    this.finalMark,
    required this.status,
  });
}
