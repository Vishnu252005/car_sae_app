import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isEditing = false;
  String? _editingEventId;

  // Controllers for form fields
  final _eventNameController = TextEditingController();
  final _eventDateController = TextEditingController();
  final _eventDescController = TextEditingController();
  int _selectedNumJudges = 1;
  int _selectedNumTeams = 1;

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _eventDescController.dispose();
    super.dispose();
  }

  Future<bool> _isUserAdmin() async {
    final user = _auth.currentUser;
    if (user == null) return false;
    
    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    return userDoc.data()?['isAdmin'] ?? false;
  }

  Future<void> _createOrUpdateEvent() async {
    if (_eventNameController.text.isEmpty || 
        _eventDateController.text.isEmpty || 
        _eventDescController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = _auth.currentUser;
      final eventData = {
        'name': _eventNameController.text,
        'date': _eventDateController.text,
        'description': _eventDescController.text,
        'numJudges': _selectedNumJudges,
        'numTeams': _selectedNumTeams,
        'lastModifiedBy': user?.uid,
        'lastModifiedAt': FieldValue.serverTimestamp(),
      };

      if (!_isEditing) {
        // Create new event
        eventData['createdBy'] = user?.uid;
        eventData['createdAt'] = FieldValue.serverTimestamp();
        await _firestore.collection('events').add(eventData);
      } else {
        // Update existing event
        await _firestore.collection('events').doc(_editingEventId).update(eventData);
      }

      // Clear form and reset editing state
      _clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isEditing ? 'Event updated successfully' : 'Event created successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
        _isEditing = false;
        _editingEventId = null;
      });
    }
  }

  void _clearForm() {
    _eventNameController.clear();
    _eventDateController.clear();
    _eventDescController.clear();
    setState(() {
      _isEditing = false;
      _editingEventId = null;
    });
  }

  void _editEvent(Map<String, dynamic> eventData, String eventId) {
    setState(() {
      _isEditing = true;
      _editingEventId = eventId;
      _eventNameController.text = eventData['name'] ?? '';
      _eventDateController.text = eventData['date'] ?? '';
      _eventDescController.text = eventData['description'] ?? '';
      _selectedNumJudges = eventData['numJudges'] ?? 1;
      _selectedNumTeams = eventData['numTeams'] ?? 1;
    });
  }

  Future<void> _showScoringDialog(String eventId, Map<String, dynamic> eventData) async {
    final scoreController = TextEditingController();
    final commentController = TextEditingController();
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter Score'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: scoreController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Score (0-100)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.star),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: commentController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Comments',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.comment),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final score = int.tryParse(scoreController.text);
              if (score == null || score < 0 || score > 100) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a valid score between 0 and 100')),
                );
                return;
              }

              final user = _auth.currentUser;
              if (user == null) return;

              await _firestore.collection('events').doc(eventId)
                  .collection('scores').add({
                'score': score,
                'comment': commentController.text,
                'judgeId': user.uid,
                'judgeName': user.displayName ?? user.email,
                'timestamp': FieldValue.serverTimestamp(),
              });

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Score submitted successfully')),
              );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildScoresSection(String eventId) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('events').doc(eventId)
          .collection('scores')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error loading scores');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final scores = snapshot.data?.docs ?? [];
        if (scores.isEmpty) {
          return Text(
            'No scores yet',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(height: 24),
            Text(
              'Scores',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 8),
            ...scores.map((score) {
              final data = score.data() as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${data['score']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['judgeName'] ?? 'Anonymous Judge',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          if (data['comment']?.isNotEmpty ?? false)
                            Text(
                              data['comment'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Event Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('events')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      title: Text(
                        _isEditing ? 'Edit Event' : 'Create Event',
                      style: TextStyle(
                          fontSize: 20,
                        fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      leading: Icon(
                        _isEditing ? Icons.edit : Icons.add_circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                    TextFormField(
                                controller: _eventNameController,
                      decoration: InputDecoration(
                        labelText: 'Event Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.event),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                                controller: _eventDateController,
                      decoration: InputDecoration(
                        labelText: 'Event Date',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(Duration(days: 365)),
                                  );
                                  if (date != null) {
                                    _eventDateController.text = 
                                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                                  }
                                },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                                controller: _eventDescController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Event Description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: _selectedNumJudges,
                                      decoration: InputDecoration(
                                        labelText: 'Number of Judges',
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.people),
                                      ),
                                      items: [1, 2, 3].map((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text('$value ${value == 1 ? 'Judge' : 'Judges'}'),
                                        );
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            _selectedNumJudges = newValue;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: DropdownButtonFormField<int>(
                                      value: _selectedNumTeams,
                                      decoration: InputDecoration(
                                        labelText: 'Number of Teams',
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.groups),
                                      ),
                                      items: [1, 2, 3, 4, 5].map((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text('$value ${value == 1 ? 'Team' : 'Teams'}'),
                                        );
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            _selectedNumTeams = newValue;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _createOrUpdateEvent,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: _isLoading
                                      ? CircularProgressIndicator(color: Colors.white)
                                      : Text(_isEditing ? 'Update Event' : 'Create Event'),
                                ),
                              ),
                            ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
              ),
              SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                  children: [
                        Container(
                          width: 4,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(width: 8),
                    Text(
                          'Upcoming Events',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.blue.shade900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (snapshot.connectionState == ConnectionState.waiting)
                SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 64,
                          color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                        Text(
                          'No events found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final event = snapshot.data!.docs[index];
                        final eventData = event.data() as Map<String, dynamic>;
                        final user = _auth.currentUser;
                        
                        return FutureBuilder<bool>(
                          future: _isUserAdmin(),
                          builder: (context, adminSnapshot) {
                            final isAdmin = adminSnapshot.data ?? false;
                            final canEdit = isAdmin || user?.uid == eventData['createdBy'];
                            
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              eventData['name'] ?? 'Unnamed Event',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            ),
                                          ),
                                          if (canEdit) ...[
                                            IconButton(
                                              icon: Icon(Icons.edit, color: Colors.blue),
                                              onPressed: () => _editEvent(eventData, event.id),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete, color: Colors.red),
                                              onPressed: () async {
                                                await _firestore
                                                    .collection('events')
                                                    .doc(event.id)
                                                    .delete();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('Event deleted')),
                                                );
                                              },
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_today,
                                                  size: 16,
                                                  color: Theme.of(context).primaryColor),
                                              SizedBox(width: 8),
                                              Text(
                                                eventData['date'] ?? 'No date',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              Icon(Icons.people,
                                                  size: 16,
                                                  color: Theme.of(context).primaryColor),
                                              SizedBox(width: 8),
                                              Text(
                                                '${eventData['numTeams']} Teams',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                    ),
                  ],
                ),
                                          SizedBox(height: 12),
                                          Text(
                                            eventData['description'] ?? 'No description',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isDark ? Colors.grey[300] : Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          FutureBuilder<bool>(
                                            future: _isUserAdmin(),
                                            builder: (context, snapshot) {
                                              final isAdmin = snapshot.data ?? false;
                                              if (!isAdmin) return SizedBox.shrink();
                                              
                                              return ElevatedButton.icon(
                                                onPressed: () => _showScoringDialog(event.id, eventData),
                                                icon: Icon(Icons.star),
                                                label: Text('Add Score'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Theme.of(context).primaryColor,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 8),
                                          _buildScoresSection(event.id),
                                        ],
              ),
            ),
          ],
        ),
                              ),
                            );
                          },
                        );
                      },
                      childCount: snapshot.data!.docs.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
} 