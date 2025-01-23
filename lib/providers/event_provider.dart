import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventProvider with ChangeNotifier {
  String? _selectedEventId;
  Map<String, dynamic>? _selectedEventData;
  
  String? get selectedEventId => _selectedEventId;
  Map<String, dynamic>? get selectedEventData => _selectedEventData;

  void setSelectedEvent(String eventId, Map<String, dynamic> eventData) {
    _selectedEventId = eventId;
    _selectedEventData = eventData;
    notifyListeners();
  }

  void clearSelectedEvent() {
    _selectedEventId = null;
    _selectedEventData = null;
    notifyListeners();
  }
} 