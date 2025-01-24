import 'package:flutter/material.dart';
import '../models/team.dart';
import '../widgets/score_input.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/event_provider.dart';

class HomeScreen extends StatefulWidget {
  final List<Team> teams;
  final bool isScrolled;

  HomeScreen({this.teams = const [], required this.isScrolled});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TeamWithId> _eventTeams = [];
  bool _isLoading = false;
  final Map<String, TextEditingController> _teamNameControllers = {};
  bool _isEditingTeamName = false;

  @override
  void initState() {
    super.initState();
    // Load event data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      if (eventProvider.selectedEventId != null) {
        _loadEventData(eventProvider.selectedEventId!, eventProvider);
      }
    });
  }

  Future<void> _loadEventData(String eventId, EventProvider eventProvider) async {
    try {
      setState(() => _isLoading = true);
      
      final eventDoc = await _firestore.collection('events').doc(eventId).get();
      final eventData = eventDoc.data() as Map<String, dynamic>;
      
      // Load existing team scores
      final teamsSnapshot = await _firestore
          .collection('events')
          .doc(eventId)
          .collection('teams')
          .orderBy('timestamp', descending: true)
          .get();

      if (teamsSnapshot.docs.isNotEmpty) {
        setState(() {
          _eventTeams = teamsSnapshot.docs.map((doc) {
            final data = doc.data();
            return TeamWithId(
              id: doc.id,
              name: data['name'] ?? 'Unnamed Team',
              scores: List<double>.from(data['scores'] ?? []),
            );
          }).toList();
        });
      } else {
        // If no teams exist, create new ones
        setState(() {
          _eventTeams = List.generate(
            eventData['numTeams'] ?? 0,
            (index) => TeamWithId(
              id: null,
              name: 'Team ${index + 1}',
              scores: [],
            ),
          );
        });
      }
    } catch (e) {
      print('Error loading event data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading event data: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveTeamScores() async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final eventId = eventProvider.selectedEventId;
    
    if (eventId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an event first')),
      );
      return;
    }

    try {
      setState(() => _isLoading = true);

      final batch = _firestore.batch();
      
      for (var team in _eventTeams) {
        final totalScore = team.scores.isNotEmpty 
            ? team.scores.reduce((a, b) => a + b)
            : 0.0;

        final teamRef = team.id != null 
            ? _firestore
                .collection('events')
                .doc(eventId)
                .collection('teams')
                .doc(team.id)
            : _firestore
                .collection('events')
                .doc(eventId)
                .collection('teams')
                .doc();

        batch.set(teamRef, {
          'name': team.name,
          'scores': team.scores,
          'totalScore': totalScore,
          'eventId': eventId,
          'timestamp': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      await batch.commit();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Scores saved successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving scores: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateTeamName(String teamId, String newName) async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final eventId = eventProvider.selectedEventId;
    
    if (eventId == null) return;

    try {
      await _firestore
          .collection('events')
          .doc(eventId)
          .collection('teams')
          .doc(teamId)
          .update({'name': newName});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Team name updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating team name: $e')),
      );
    }
  }

  Widget _buildEventSelector(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final eventProvider = Provider.of<EventProvider>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('events')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error loading events');
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final events = snapshot.data!.docs;
        if (events.isEmpty) {
          return Text('No events available');
        }

        return Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark 
                    ? Colors.black.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: eventProvider.selectedEventId,
              isExpanded: true,
              hint: Text(
                'Select an Event',
                style: TextStyle(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
              items: events.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return DropdownMenuItem<String>(
                  value: doc.id,
                  child: Text(
                    data['name'] ?? 'Unnamed Event',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? eventId) {
                if (eventId != null) {
                  final eventData = events
                      .firstWhere((doc) => doc.id == eventId)
                      .data() as Map<String, dynamic>;
                  eventProvider.setSelectedEvent(eventId, eventData);
                  _loadEventData(eventId, eventProvider);
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final eventProvider = Provider.of<EventProvider>(context);
    final selectedEventId = eventProvider.selectedEventId;
    final selectedEventData = eventProvider.selectedEventData;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildEventSelector(context),
          ),
          SliverFillRemaining(
            child: _isLoading 
                ? Center(child: CircularProgressIndicator())
                : selectedEventId == null || selectedEventData == null
                    ? Center(
                                child: Text(
                          'Please select an event',
                                  style: TextStyle(
                                    fontSize: 16,
                            color: isDark ? Colors.white70 : Colors.grey.shade700,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                              selectedEventData['name'] ?? 'Unnamed Event',
                    style: TextStyle(
                                fontSize: 24,
                      fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.blue.shade900,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Number of Judges: ${selectedEventData['numJudges'] ?? 0}',
                              style: TextStyle(
                                color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                              ),
                            ),
                            SizedBox(height: 24),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _eventTeams.length,
                    itemBuilder: (context, index) {
                      final team = _eventTeams[index];
                      _teamNameControllers.putIfAbsent(
                        team.id ?? 'team_$index',
                        () => TextEditingController(text: team.name),
                      );
                      
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text('${index + 1}'),
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: _isEditingTeamName
                                        ? TextField(
                                            controller: _teamNameControllers[team.id ?? 'team_$index'],
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 8,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            team.name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      _isEditingTeamName ? Icons.check : Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      if (_isEditingTeamName) {
                                        _updateTeamName(
                                          team.id ?? 'team_$index',
                                          _teamNameControllers[team.id ?? 'team_$index']!.text,
                                        );
                                      }
                                      setState(() {
                                        _isEditingTeamName = !_isEditingTeamName;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            ScoreInput(
                              team: team,
                              numJudges: selectedEventData['numJudges'] ?? 1,
                              maxScore: 100,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveTeamScores,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text('Save Scores'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _teamNameControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}

