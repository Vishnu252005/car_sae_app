import 'package:car_sae_app/Raisedgradientbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class volvoserviceandrepairmanuals extends StatelessWidget {
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
                colors: [Colors.purpleAccent, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text('service and repair manuals',
              style: TextStyle(color: Colors.white)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'service and repair manuals',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Below you can find links to download for free the service and repair manual',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 500.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: RaisedGradientButton(
                            height: 50.0,
                            width: 300.0,
                            key:
                                UniqueKey(), // Provide a unique key or your desired key
                            onPressed: () {},
                            gradient: const LinearGradient(
                              colors: <Color>[Colors.purpleAccent, Colors.blue],
                            ),
                            child: const Text(
                              'upload it and share it',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
