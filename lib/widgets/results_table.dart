import 'package:flutter/material.dart';
import '../models/team.dart';

class ResultsTable extends StatelessWidget {
  final List<Team> teams;

  ResultsTable({required this.teams});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 24,
        headingRowHeight: 48,
        dataRowHeight: 56,
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade900,
        ),
        columns: [
          DataColumn(
            label: Text('Rank'),
            numeric: true,
          ),
          DataColumn(label: Text('Team')),
          DataColumn(
            label: Text('Total Score'),
            numeric: true,
          ),
        ],
        rows: List.generate(teams.length, (index) {
          final team = teams[index];
          return DataRow(
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text(team.name)),
              DataCell(Text(team.totalScore.toString())),
            ],
            color: MaterialStateProperty.resolveWith<Color?>((states) {
              if (index == 0) return Colors.blue.withOpacity(0.1);
              if (index == 1) return Colors.blue.withOpacity(0.05);
              if (index == 2) return Colors.blue.withOpacity(0.02);
              return null;
            }),
          );
        }),
      ),
    );
  }
}
