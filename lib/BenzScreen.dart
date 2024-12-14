import 'package:car_sae_app/benzfuzediagram.dart';
import 'package:car_sae_app/benzreport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Raisedgradientbutton.dart';

class BenzScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text(
            'Benz',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // Use Column to arrange the buttons vertically
            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
            children: [
              ///////////////////////////////////////////////////////////
              SizedBox(
                width: 400, // Set width of the button
                height: 50,
                child: RaisedGradientButton(
                  key: UniqueKey(), // Provide a unique key or your desired key
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => benzreport()),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.blueAccent, Colors.green],
                  ),
                  child: const Text(
                    'Owner"s Reviews',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              /////////////////////////////////////////////////////////////////
              SizedBox(
                width: 400, // Set width of the button
                height: 50,
                child: RaisedGradientButton(
                  key: UniqueKey(), // Provide a unique key or your desired key
                  onPressed: () {},
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.blueAccent, Colors.green],
                  ),
                  child: const Text(
                    'Owner"s Manuals',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400, // Set width of the button
                height: 50,
                child: RaisedGradientButton(
                  key: UniqueKey(), // Provide a unique key or your desired key
                  onPressed: () {
                    // Handle button press
                  },
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.blueAccent, Colors.green],
                  ),
                  child: const Text(
                    'Service and Repair Manuals',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 400, // Set width of the button
                height: 50,
                child: RaisedGradientButton(
                  key: UniqueKey(), // Provide a unique key or your desired key
                  onPressed: () {
                    // Handle button press
                  },
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.blueAccent, Colors.green],
                  ),
                  child: const Text(
                    'Useful Guides',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between buttons
              SizedBox(
                width: 400, // Set width of the button
                height: 50,
                child: RaisedGradientButton(
                  key: UniqueKey(), // Provide a unique key or your desired key
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => benzfusediagram()),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.blueAccent, Colors.green],
                  ),
                  child: const Text(
                    'Fuse Diagrams',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
