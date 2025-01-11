import 'package:flutter/material.dart';

class KnowledgeBaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Knowledge Base')),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search solutions...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSolutionCard('Common Engine Issues'),
                _buildSolutionCard('DIY Brake Fixes'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionCard(String title) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        onTap: () {
          // Navigate to detailed solution
        },
      ),
    );
  }
} 