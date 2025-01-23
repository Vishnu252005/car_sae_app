class TeamWithId {
  String? id;
  String name;
  List<double> scores;
  double get totalScore => scores.isEmpty ? 0 : scores.reduce((a, b) => a + b) / scores.length;

  TeamWithId({
    this.id,
    required this.name,
    required this.scores,
  });
} 