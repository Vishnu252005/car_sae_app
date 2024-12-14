import 'package:car_sae_app/VolvoScreen.dart';
import 'package:car_sae_app/BenzScreen.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _controller = TextEditingController();
  List<String> _allScreens = [
    'Volvo',
    'Benz',
    'Bugatti',
    'Lamborghini'
  ]; // List of available screens
  List<String> _filteredScreens = [];

  @override
  void initState() {
    super.initState();
    _filteredScreens = []; // Start with an empty filtered list
  }

  void _filterScreens(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredScreens = []; // Hide the list when search bar is empty
      } else {
        _filteredScreens = _allScreens
            .where(
                (screen) => screen.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading:
              false, // Optional, depending on your layout
          backgroundColor:
              Colors.transparent, // Set backgroundColor to transparent
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.yellow,
                  Colors.orange,
                ], // Your gradient colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu), // Hamburger icon
            onPressed: () {
              // Add functionality for menu (optional)
            },
          ),
          title: const Text(
            'Home',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person), // Profile icon
              onPressed: () {
                // Add functionality for profile (optional)
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 200), // Empty space for logo or title
            // Search Bar
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search Screens',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: _filterScreens, // Call this function when typing
            ),
            const SizedBox(height: 10),
            // Only show the list if there are filtered results
            if (_filteredScreens.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredScreens.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredScreens[index]),
                      onTap: () {
                        // Navigate to the selected screen
                        if (_filteredScreens[index] == 'Volvo') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VolvoScreen()),
                          );
                        } else if (_filteredScreens[index] == 'Benz') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BenzScreen()),
                          );
                        }
                        /////////////////////////////
                        else if (_filteredScreens[index] == 'Bugatti') {
                        } else if (_filteredScreens[index] == 'Lamborghini') {}
                        /////////////////////////////////
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
