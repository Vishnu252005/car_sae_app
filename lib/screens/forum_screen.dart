import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community Forum')),
      body: ListView(
        children: [
          _buildThreadCard('Engine Overheating Discussion'),
          _buildThreadCard('Brake Problems'),
        ],
      ),
    );
  }

  Widget _buildThreadCard(String title) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        onTap: () {
          // Navigate to thread details
        },
      ),
    );
  }
} 