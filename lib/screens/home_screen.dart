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

  Future<void> _loadEventData(String eventId, EventProvider eventProvider) async {
    try {
      if (eventId == eventProvider.selectedEventId) return;
      
      final eventDoc = await _firestore.collection('events').doc(eventId).get();
      final eventData = eventDoc.data() as Map<String, dynamic>;
      
      eventProvider.setSelectedEvent(eventId, eventData);
      
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
            ? team.scores.reduce((a, b) => a + b) / team.scores.length
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            elevation: widget.isScrolled ? 4 : 0,
            backgroundColor: widget.isScrolled 
                ? (isDark ? Color(0xFF1F1F1F) : Colors.white)
                : Colors.transparent,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final top = constraints.biggest.height;
                final expandedHeight = 200.0;
                final shrinkOffset = expandedHeight - top;
                final progress = shrinkOffset / expandedHeight;
                
                return FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                  title: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: progress,
                    child: Text(
                      '',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark 
                            ? [Color(0xFF1F1F1F), Color(0xFF121212)]
                            : [Colors.blue.shade700, Colors.blue.shade500],
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Gradient Background
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade700,
                                Colors.blue.shade500,
                              ],
                            ),
                          ),
                        ),
                        // Decorative Circles
                        Positioned(
                          right: -50,
                          top: -50,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -30,
                          bottom: -30,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        // Add Event Selector
                        Positioned(
                          top: 40,
                          left: 16,
                          right: 16,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _firestore.collection('events')
                                .orderBy('date', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }

                              final events = snapshot.data!.docs;
                              
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: eventProvider.selectedEventId,
                                    hint: Text(
                                      'Select Event',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    dropdownColor: isDark 
                                        ? Colors.grey.shade900 
                                        : Colors.white,
                                    items: events.map((event) {
                                      final eventData = 
                                          event.data() as Map<String, dynamic>;
                                      return DropdownMenuItem<String>(
                                        value: event.id,
                                        child: Text(
                                          eventData['name'] ?? 'Unnamed Event',
                                          style: TextStyle(
                                            color: isDark 
                                                ? Colors.white 
                                                : Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? eventId) {
                                      if (eventId != null) {
                                        _loadEventData(eventId, eventProvider);
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        // Central Content
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Icon(
                                  Icons.emoji_events_rounded,
                                  size: 48,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${widget.teams.length} Teams Participating',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: _buildTeamsSection(isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsSection(bool isDark) {
    final eventProvider = Provider.of<EventProvider>(context);
    final selectedEventData = eventProvider.selectedEventData;

    if (eventProvider.selectedEventId == null) {
      return Center(
        child: Text(
          'Please select an event',
          style: TextStyle(
            fontSize: 18,
            color: isDark ? Colors.white70 : Colors.grey.shade700,
          ),
        ),
      );
    }

    if (selectedEventData == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team Scores',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Event: ${selectedEventData['name']}',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white70 : Colors.grey.shade600,
          ),
        ),
        Text(
          'Judges: ${selectedEventData['numJudges']}',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white70 : Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _eventTeams.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(bottom: 16),
              elevation: 4,
              color: isDark ? Color(0xFF1F1F1F) : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark 
                          ? Colors.blue.shade900.withOpacity(0.2)
                          : Colors.blue.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isDark 
                              ? Colors.blue.shade900.withOpacity(0.3)
                              : Colors.blue.shade100,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isDark 
                                  ? Colors.blue.shade200
                                  : Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            initialValue: _eventTeams[index].name,
                            onChanged: (value) {
                              setState(() {
                                _eventTeams[index].name = value;
                              });
                            },
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Team Name',
                              labelStyle: TextStyle(
                                color: isDark 
                                    ? Colors.blue.shade200
                                    : Colors.blue.shade900,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: isDark 
                                  ? Color(0xFF2A2A2A)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ScoreInput(
                    team: _eventTeams[index],
                    numJudges: selectedEventData['numJudges'] ?? 1,
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _saveTeamScores,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: _isLoading 
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Icon(Icons.save),
            label: Text(
              _isLoading ? 'Saving...' : 'Save Scores',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

