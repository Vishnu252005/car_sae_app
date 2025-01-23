class Team {
  String name;
  List<double> scores;  // Change to List<double> and make it required

  Team({
    required this.name,
    required this.scores,  // Add scores parameter
  });

  double get totalScore => scores.fold(0, (sum, score) => sum + score);
}

class TeamWithId extends Team {
  final String? id;
  
  TeamWithId({
    required String name,
    required List<double> scores,
    this.id,
  }) : super(name: name, scores: scores);
}
