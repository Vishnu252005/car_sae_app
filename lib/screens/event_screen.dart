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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('events')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Creation/Edit Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _isEditing ? 'Edit Event' : 'Create Event',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.blue.shade900,
                              ),
                            ),
                            if (_isEditing)
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: _clearForm,
                              ),
                          ],
                        ),
                        SizedBox(height: 16),
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
                ),
                SizedBox(height: 24),

                // Events List
                Text(
                  'Upcoming Events',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 16),
                if (snapshot.connectionState == ConnectionState.waiting)
                  Center(child: CircularProgressIndicator())
                else if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                  Center(child: Text('No events found'))
                else
                  FutureBuilder<bool>(
                    future: _isUserAdmin(),
                    builder: (context, adminSnapshot) {
                      final isAdmin = adminSnapshot.data ?? false;
                      
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final event = snapshot.data!.docs[index];
                          final eventData = event.data() as Map<String, dynamic>;
                          final user = _auth.currentUser;
                          final canEdit = isAdmin || user?.uid == eventData['createdBy'];
                          
                          return Card(
                            margin: EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text(
                                eventData['name'] ?? 'Unnamed Event',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 16),
                                      SizedBox(width: 8),
                                      Text(eventData['date'] ?? 'No date'),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(eventData['description'] ?? 'No description'),
                                ],
                              ),
                              trailing: canEdit ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => _editEvent(eventData, event.id),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
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
                              ) : null,
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
} 