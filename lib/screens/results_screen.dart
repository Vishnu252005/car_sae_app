import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import '../models/team.dart';
import '../widgets/results_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/team_score.dart';
import '../providers/event_provider.dart';

class ResultsScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final selectedEventId = eventProvider.selectedEventId;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (selectedEventId == null) {
      return Center(child: Text('Please select an event'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('events')
          .doc(selectedEventId)
          .collection('teams')
          .orderBy('totalScore', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final teams = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return TeamScore.fromFirestore(data, doc.id);
        }).toList();

        final winner = teams.isNotEmpty ? teams.first : null;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (winner != null) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark 
                            ? [Colors.blue.shade900, Colors.blue.shade800]
                            : [Colors.blue.shade100, Colors.blue.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.emoji_events, size: 48, color: Colors.amber),
                        SizedBox(height: 8),
                        Text(
                          'Winner',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.blue.shade900,
                          ),
                        ),
                        Text(
                          winner.name,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.blue.shade700,
                          ),
                        ),
                        Text(
                          'Score: ${winner.totalScore.toStringAsFixed(1)}',
                          style: TextStyle(
                            fontSize: 24,
                            color: isDark ? Colors.white70 : Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final team = teams[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: index == 0 
                              ? Colors.amber 
                              : index == 1 
                                  ? Colors.grey[300] 
                                  : index == 2 
                                      ? Colors.brown[300] 
                                      : Colors.blue[100],
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: index == 0 
                                  ? Colors.black 
                                  : Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          team.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Individual Scores: ${team.scores.map((s) => s.toStringAsFixed(1)).join(", ")}',
                        ),
                        trailing: Text(
                          team.totalScore.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: index == 0 ? Colors.amber : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
