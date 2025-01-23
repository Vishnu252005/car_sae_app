class Team {
  String name;
  List<double> scores;  // Change to List<double> and make it required

  Team({
    required this.name,
    required this.scores,  // Add scores parameter
  });

  double get totalScore => scores.fold(0, (sum, score) => sum + score);
}
