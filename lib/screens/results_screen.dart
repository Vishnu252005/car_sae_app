import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import '../models/team.dart';
import '../widgets/results_table.dart';

class ResultsScreen extends StatelessWidget {
  final List<Team> teams;

  ResultsScreen({required this.teams});

  Future<void> exportToCsv(BuildContext context, List<List<dynamic>> rows) async {
    try {
      final String csv = const ListToCsvConverter().convert(rows);
      final Directory directory = await getApplicationDocumentsDirectory();
      final String path = '${directory.path}/scores_${DateTime.now().millisecondsSinceEpoch}.csv';
      final File file = File(path);
      await file.writeAsString(csv);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CSV file saved to: $path')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error exporting CSV: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    teams.sort((a, b) => b.totalScore.compareTo(a.totalScore));
    final winner = teams.isNotEmpty ? teams.first : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              exportToCsv(
                context,
                [
                  ['Team', 'Total Score'],
                  ...teams.map((team) => [team.name, team.totalScore])
                ],
              );
            },
          ),
        ],
      ),
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
                    colors: [Colors.blue.shade100, Colors.blue.shade50],
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
                        color: Colors.blue.shade900,
                      ),
                    ),
                    Text(
                      winner.name,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    Text(
                      'Score: ${winner.totalScore}',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'All Results',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
            Card(
              margin: EdgeInsets.all(16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ResultsTable(teams: teams),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
