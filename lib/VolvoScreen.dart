import 'package:car_sae_app/volvofusediagram.dart';
import 'package:car_sae_app/volvoownermanuals.dart';
import 'package:car_sae_app/volvoownerreview.dart';
import 'package:car_sae_app/volvoserviceandrepairmanuals.dart';
import 'package:car_sae_app/volvouserguides.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Raisedgradientbutton.dart';

class VolvoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor:
              Colors.transparent, // Make the default background transparent
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purpleAccent, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text('Volvo', style: TextStyle(color: Colors.white)),
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
                      MaterialPageRoute(builder: (context) => volvoreport()),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.purpleAccent, Colors.blue],
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => volvoownermanual()),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.purpleAccent, Colors.blue],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => volvoserviceandrepairmanuals()),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.purpleAccent, Colors.blue],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Volvouserguides()),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.purpleAccent, Colors.blue],
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
                          builder: (context) => volvofusediagram()),
                    );
                  },
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.purpleAccent, Colors.blue],
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
