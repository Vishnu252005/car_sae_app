import 'dart:io';
import 'package:car_sae_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Raisedgradientbutton.dart';

class AddNewTask1 extends StatefulWidget {
  const AddNewTask1({super.key});

  @override
  State<AddNewTask1> createState() => _AddNewTask1State();
}

class _AddNewTask1State extends State<AddNewTask1> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Color _selectedColor = Colors.blue;
  File? file;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> uploadToDB() async {
    try {
      final data = await FirebaseFirestore.instance.collection("tasks").add({
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "creator": FirebaseAuth.instance.currentUser!.uid,
        "time": FieldValue.serverTimestamp(),
        "color": rgbToHex(_selectedColor),
      });
      print(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Transparent background
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text('Add your review'),
          actions: [
            GestureDetector(
              onTap: () async {
                final selDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    const Duration(days: 90),
                  ),
                );
                if (selDate != null) {
                  setState(() {
                    selectedDate = selDate;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat('MM-d-y').format(selectedDate),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          // Makes the body scrollable
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                /*ColorPicker(
                  pickersEnabled: const {
                    ColorPickerType.wheel: true,
                  },
                  color: _selectedColor,
                  onColorChanged: (Color color) {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  heading: const Text('Select color'),
                  subheading: const Text('Select a different shade'),
                ),*/
                const SizedBox(height: 10),
                Center(
                  child: RaisedGradientButton(
                    height: 50.0,
                    width: 150.0,
                    key: UniqueKey(),
                    onPressed: () async {
                      await uploadToDB();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Task added successfully!')),
                      );
                    },
                    gradient: const LinearGradient(
                      colors: <Color>[Colors.blueAccent, Colors.green],
                    ),
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Add spacing to avoid overflow
              ],
            ),
          ),
        ),
      ),
    );
  }
}
