import 'package:cloud_firestore/cloud_firestore.dart';

class TeamScore {
  final String id;
  final String name;
  final List<double> scores;
  final double totalScore;
  final String eventId;
  final DateTime timestamp;

  TeamScore({
    required this.id,
    required this.name,
    required this.scores,
    required this.totalScore,
    required this.eventId,
    required this.timestamp,
  });

  factory TeamScore.fromFirestore(Map<String, dynamic> data, String id) {
    return TeamScore(
      id: id,
      name: data['name'] ?? 'Unnamed Team',
      scores: List<double>.from(data['scores'] ?? []),
      totalScore: (data['totalScore'] ?? 0.0).toDouble(),
      eventId: data['eventId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
} 