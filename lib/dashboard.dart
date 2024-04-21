import 'package:blood/accepted_request.dart';
import 'package:blood/help.dart';
import 'package:blood/list.dart';
import 'package:blood/login.dart';
import 'package:blood/profilepage.dart';
import 'package:blood/view_request.dart';
import 'package:flutter/material.dart';

import 'request.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DASHBOARD',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ElevatedButton(
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.red[700]),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserList()));
                    },
                    child: Text(
                      "USERS",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ElevatedButton(
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.red[700]),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BloodRequestPage()));
                    },
                    child: Text(
                      "ADD REQUEST",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ElevatedButton(
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.red[700]),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestList()));
                    },
                    child: Text(
                      "VIEW REQUEST",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ElevatedButton(
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.red[700]),
                    onPressed: () {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcceptedRequestList()));


                    },
                    child: Text(
                      "ACCEPTED",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ElevatedButton(
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.red[700]),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                    child: Text(
                      "PROFILE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: ElevatedButton(
                    style:
                        TextButton.styleFrom(backgroundColor: Colors.red[700]),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HelpPage()));
                    },
                    child: Text(
                      "HELP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(width: 50),

             SizedBox(
                      width: 180,
                      height: 180,
                      child: ElevatedButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red[700]),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),), (route) => false);
                         
                        },
                        child: Text(
                          "LOGOUT",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
              
            
          ],
        ),
      ),
    );
  }
}
