import 'dart:js_util';

import 'package:blood/view_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BloodRequestPage extends StatefulWidget {
  @override
  _BloodRequestPageState createState() => _BloodRequestPageState();
}

class _BloodRequestPageState extends State<BloodRequestPage> {
  String? _selectedBloodType;

  TextEditingController _detailsController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  bool loading = false;

  String?
      _selectedBloodGroup; // Define a variable to store the selected blood group
  List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ]; // List of blood groups

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Blood'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Blood Type:',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.purple.shade50,
                      prefixIcon: Icon(Icons.bloodtype_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.vertical(),
                      ),
                      hintText: 'Blood Group',
                    ),
                    value: _selectedBloodGroup,
                    items: _bloodGroups.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedBloodGroup = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),

                  TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    prefixIcon: Icon(Icons.calendar_month),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.vertical(),
                    ),
                    hintText: 'Age',
                  ),
                  
                ),
                SizedBox(height: 10,),
                  const Text(
                    'Additional Details (Optional):',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _detailsController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Enter any additional details...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      // Changed from RaisedButton to ElevatedButton
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.all(30)),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });

                        if (_selectedBloodGroup != null) {
                          await requstForBlood(context, _selectedBloodGroup!, _ageController.text,
                              _detailsController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Select blood group')));
                        }

                        setState(() {
                          loading = false;
                        });
                      },
                      child: const Text(
                        'Submit Request',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> requstForBlood(BuildContext context, String bloodGroup, String? age,
      String? description) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('bloodBank').doc().set({
        'bloodGroup': bloodGroup,
        'userId': userId,
        'age': age ?? '10',
        'description': description ?? 'desc',
        'status': 0 //pending
      }, SetOptions(merge: true));



      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RequestList(),));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Request added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Failed to add user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add  data'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void submitRequest() {
    // Implement your logic to submit the request to the backend or perform any other action
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }
}
