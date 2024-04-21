
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phonenumberController= TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _medicalHistoryController = TextEditingController();
  TextEditingController _dateofbirthController = TextEditingController();
  TextEditingController _bloodgroupController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  bool _passwordsMatch = true;
  DateTime? _selectedDate;
  String? _selectedBloodGroup; // Define a variable to store the selected blood group
  List<String> _bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']; // List of blood groups

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  bool loading =  false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SIGNUP',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: loading ? Center(child: CircularProgressIndicator(),)  : Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical(),
                        ),
                        hintText: 'First Name',
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _medicalHistoryController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical(),
                        ),
                        hintText: 'Medical History',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical(),
                        ),
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        // Simple email format validation
                        String emailPattern =
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                        RegExp regex = RegExp(emailPattern);
                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                 
                 
                 
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _phonenumberController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical(),
                        ),
                        hintText: 'Phone Number',
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        if (value.length != 10) {
                          return 'Enter a 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    prefixIcon: Icon(Icons.person_2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.vertical(),
                    ),
                    hintText: 'Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),

              SizedBox(height: 20,),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical(),
                        ),
                        hintText: 'Date of Birth',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      readOnly: true,
                      controller: TextEditingController(
                        text: _selectedDate != null
                            ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                            : '',
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                 
                 
                 
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical(),
                        ),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.vertical(),
                        ),
                        hintText: 'Confirm Password',
                        errorText: _passwordsMatch ? null : 'Passwords do not match',
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
                  onPressed: () async {

                    if(formkey.currentState!.validate()){


                      if (_passwordController.text == _confirmPasswordController.text) {

                        setState(() {
                          loading = true;
                        });

                       if(_selectedDate != null && _bloodGroups != null){


                         await  signUp(
                             email: _emailController.text,
                             password: _confirmPasswordController.text,
                             bldGp: _selectedBloodGroup!,
                             medHistory: _medicalHistoryController.text,
                             name: _nameController.text,
                             phone: _phonenumberController.text,
                             address:_addressController.text,
                             dob:'${_selectedDate!.day}- ${_selectedDate!.month} - ${_selectedDate!.year} '

                         );

                         Navigator.pop(context);
                        

                       }








                        setState(() {
                          loading = false;
                          _passwordsMatch = true;
                        });

                      } else {

                        setState(() {
                          _passwordsMatch = false;
                        });
                      }

                    }

                  },
                  child: Text('SIGNUP', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp({
    required String email,
    required String password,
    required String name,
    required String medHistory,
    required String bldGp,
    required String phone,
    required String address,
    required String dob
  }) async {
    try {
      // Creating user in FirebaseAuth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      String uid = userCredential.user!.uid;


      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'medHistory': medHistory,
        'bldGp': bldGp,
        'phone': phone,
        'address': address,
        'dob' : dob,
        'email' : email
      });


      

      return null; // Sign up successful
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message
    }
  }



}
