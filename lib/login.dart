import 'package:blood/dashboard.dart';
import 'package:blood/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
   bool _obscurePassword = true;

   final formKey = GlobalKey<FormState>();

   bool  loading =  false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      body: loading ?  Center(child: CircularProgressIndicator(),) : Container(
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Form(
            key:  formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'login',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                TextFormField(
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
                    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                    RegExp regex = RegExp(emailPattern);
                    if (!regex.hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
            
                const SizedBox(
                  height: 10,
                ),
               TextFormField(
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
                
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                        onPressed: ()  async{
            
                          if(formKey.currentState!.validate()){


                            setState(() {
                            loading =  false;
                          });
            
                          await  loginUser(context: 
                          context, email: _emailController.text, 
                          password: _passwordController.text);
            
                          setState(() {
                            loading = false;
                          });

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                        ),
                        child: const Text(
                          'login',
                          style: TextStyle(color: Colors.black),
                        )),
            
                Text('not a member?'),
                const SizedBox(
                  width: 4,
                ),
            //            Text('register now',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                TextButton(
                  onPressed: () {},
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignupPage()));
                    },
                    child: Text(
                      'register now',
                      style: TextStyle(
                          color: Colors.red[700], fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );


    
  }


  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password
    }) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );


    if(userCredential.user != null){

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ButtonPage(),), (route) => false);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login successful')),
    );
    // You can navigate to another screen here if needed
  } on FirebaseAuthException catch (e) {
    // If login fails, show an error message using a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed: ${e.code}')),
    );
  }
}
}
