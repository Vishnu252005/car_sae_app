import 'package:flutter/material.dart';

class EmergencyHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emergency Help')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implement emergency call or service
          },
          child: Text('Call for Help'),
        ),
      ),
    );
  }
} 