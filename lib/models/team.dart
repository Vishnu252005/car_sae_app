class Team {
  final String name;
  final List<double> scores;
  double get totalScore => scores.isEmpty ? 0 : scores.reduce((a, b) => a + b);

  Team({
    required this.name,
    required this.scores,
  });
}

class TeamWithId {
  String? id;
  String name;
  List<double> scores;
  double get totalScore => scores.isEmpty ? 0 : scores.reduce((a, b) => a + b);

  TeamWithId({
    this.id,
    required this.name,
    required this.scores,
  });
}
