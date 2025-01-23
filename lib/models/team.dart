class Team {
  String name;
  List<int> scores; // Scores from 3 judges
  int totalScore;

  Team({required this.name})
      : scores = List.filled(3, 0),
        totalScore = 0;

  void calculateTotalScore() {
    totalScore = scores.reduce((a, b) => a + b);
  }
}
