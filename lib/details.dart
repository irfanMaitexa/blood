import 'package:blood/list.dart';
import 'package:flutter/material.dart';


class UserDetailsChart extends StatelessWidget {


  
  UserDetailsChart(this.user);


  final User user;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(1), // Name column
            1: FlexColumnWidth(1), // Value column
          },
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TableCell(
                  child: Text(user.name??'pravishna'),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    'DOB',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TableCell(
                  child: Text(user.age ?? '18'.toString()),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    'Blood Group',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TableCell(
                  child: Text(user.bloodGroup ?? '+v'),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    'Medical History',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TableCell(
                  child: Text(user.medicalHistory ?? 'fully fit'),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TableCell(
                  child: Text(user.phoneNumber?? '1234567890'),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Text(
                    'Address',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TableCell(
                  child: Text(user.address ?? 'abc house po thalassery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
