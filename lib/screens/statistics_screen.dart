import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/team.dart';
import '../models/team_score.dart';
import '../providers/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsScreen extends StatelessWidget {
  StatisticsScreen();

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final selectedEventId = eventProvider.selectedEventId;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (selectedEventId == null) {
      return Center(child: Text('Please select an event'));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Statistics'),
        elevation: 0,
        backgroundColor: isDark ? Color(0xFF1F1F1F) : Colors.blue.shade700,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
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

          // Build content once to prevent rebuilds
          final content = Column(
            children: [
              _buildScoreDistributionCard(context, teams),
              SizedBox(height: 16),
              _buildTopTeamsCard(context, teams),
              SizedBox(height: 16),
              _buildAverageScoresCard(context, teams),
            ],
          );

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              return true; // Prevents scroll notifications from bubbling up
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: content,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildScoreDistributionCard(BuildContext context, List<TeamScore> teams) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Calculate max score for y-axis
    final maxScore = teams.isEmpty 
        ? 300.0 
        : teams.map((t) => t.totalScore).reduce((a, b) => a > b ? a : b);
    final roundedMaxScore = ((maxScore / 100).ceil() * 100).toDouble();

    return Card(
      elevation: 8,
      color: isDark ? Color(0xFF1F1F1F) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score Distribution',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.blue.shade900,
                  ),
                ),
                Icon(
                  Icons.bar_chart,
                  color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                  size: 28,
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              padding: EdgeInsets.only(right: 16, bottom: 24),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: roundedMaxScore,
                  minY: 0,
                  groupsSpace: 20,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blue.shade700,
                      tooltipRoundedRadius: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${teams[group.x.toInt()].name}\n${rod.toY.round()} points',
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Text(
                                teams[value.toInt()].name,
                                style: TextStyle(
                                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: roundedMaxScore / 6,
                        getTitlesWidget: (value, meta) {
                          if (value % (roundedMaxScore / 3) == 0) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          }
                          return Text('');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 50,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: value % 100 == 0 
                            ? (isDark ? Colors.grey.shade700 : Colors.grey.shade300)
                            : (isDark ? Colors.grey.shade800.withOpacity(0.5) : Colors.grey.shade200.withOpacity(0.5)),
                        strokeWidth: value % 100 == 0 ? 1.5 : 0.5,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: teams.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.totalScore.toDouble(),
                          gradient: LinearGradient(
                            colors: isDark 
                                ? [Colors.blue.shade700, Colors.blue.shade400]
                                : [Colors.blue.shade300, Colors.blue.shade500],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          width: 24,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(6),
                          ),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: roundedMaxScore,
                            color: isDark 
                                ? Colors.grey.shade800.withOpacity(0.5)
                                : Colors.grey.shade100,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTeamsCard(BuildContext context, List<TeamScore> teams) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sortedTeams = List<TeamScore>.from(teams)
      ..sort((a, b) => b.totalScore.compareTo(a.totalScore));
    final topTeams = sortedTeams.take(3).toList();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      elevation: 4,
      color: isDark ? Color(0xFF1F1F1F) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Performers',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.blue.shade900,
                  ),
                ),
                if (topTeams.isNotEmpty) Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 28,
                ),
              ],
            ),
            SizedBox(height: 16),
            ...topTeams.asMap().entries.map((entry) {
              final rank = entry.key;
              final team = entry.value;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: rank == 0 
                      ? Colors.amber 
                      : rank == 1 
                          ? Colors.grey[300] 
                          : Colors.brown[300],
                  child: Text(
                    '${rank + 1}',
                    style: TextStyle(
                      color: rank == 0 ? Colors.black : Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  team.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: rank == 0 ? Colors.amber : null,
                  ),
                ),
                trailing: Text(
                  team.totalScore.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: rank == 0 ? Colors.amber : Colors.blue.shade700,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildAverageScoresCard(BuildContext context, List<TeamScore> teams) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Calculate average score
    final averageScore = teams.isEmpty
        ? 0.0
        : teams.map((t) => t.totalScore).reduce((a, b) => a + b) / teams.length;

    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      color: isDark ? Color(0xFF1F1F1F) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Average Score',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? Colors.blue.shade900.withOpacity(0.2) : Colors.blue.shade50,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        averageScore.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        'points',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.blue.shade300 : Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 