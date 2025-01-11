import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 20), // Space between search bar and content
            Expanded(
              child: ListView(
                children: [
                  _buildSectionTitle('Popular Topics'),
                  _buildCard('Engine Overheating'),
                  _buildCard('Brake Issues'),
                  _buildSectionTitle('Latest Reports'),
                  _buildCard('Battery Not Charging'),
                  _buildSectionTitle('Recommended Solutions'),
                  _buildCard('Oil Change Tips'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for problems or solutions...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.blue),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCard(String title) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title),
        onTap: () {
          // Navigate to detailed view
        },
      ),
    );
  }
} 