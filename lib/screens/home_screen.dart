import 'package:flutter/material.dart';
import '../ai/screens/HomePage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cardo'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification action
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Text('Welcome to Cardo!'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()), // Navigate to ChatbotScreen
          );
        },
        child: Icon(Icons.chat), // Chatbot icon
        tooltip: 'Chat with us', // Tooltip for the button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Positioning the button to the right
    );
  }
} 