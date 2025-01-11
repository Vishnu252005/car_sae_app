import 'package:flutter/material.dart';

class KnowledgeBaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge Base'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Knowledge Base',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
      ),
    );
  }
} 