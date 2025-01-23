import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/team.dart';

class EventProvider with ChangeNotifier {
  String? _selectedEventId;
  Map<String, dynamic>? _selectedEventData;
  List<TeamWithId>? _eventTeams;
  
  String? get selectedEventId => _selectedEventId;
  Map<String, dynamic>? get selectedEventData => _selectedEventData;
  List<TeamWithId>? get eventTeams => _eventTeams;

  void setSelectedEvent(String eventId, Map<String, dynamic> eventData) {
    _selectedEventId = eventId;
    _selectedEventData = eventData;
    notifyListeners();
  }

  void setEventTeams(List<TeamWithId> teams) {
    _eventTeams = teams;
    notifyListeners();
  }

  void clearSelectedEvent() {
    _selectedEventId = null;
    _selectedEventData = null;
    _eventTeams = null;
    notifyListeners();
  }
} 