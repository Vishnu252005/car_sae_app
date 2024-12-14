import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class benzfusediagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Fuse Diagram')),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor:
              Colors.transparent, // Make the default background transparent
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title:
              const Text('Fuse Diagram', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Center(child: Text('This is the screen')),
    );
  }
}
