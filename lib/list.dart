import 'package:blood/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
   String ? id;
   String  ? age;
   String ? name;
   String ? bloodGroup;
   String ? medicalHistory;
   String ? phoneNumber;
   String ? address;

  User({
     this.id,
     this.name,
     this.age,
     this.bloodGroup,
     this.medicalHistory,
     this.phoneNumber,
     this.address,
  });
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<User> users = snapshot.data!.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          return User(

            id: doc.id,

            name: data['name'],
            phoneNumber: data['phone'],
            medicalHistory: data['medHistory'],
            bloodGroup: data['bldGp'],
            address: data['address'],
            age: data['dob']
          

          );
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: [
              DataColumn(label: Text('SL No.')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Phone Number')),
              DataColumn(label: Text('Details')),

            ],
            rows: users.map((person) {
              return DataRow(cells: [
                DataCell(Text(person.id.toString())),
                DataCell(Text(person.name ?? 'name')),
                DataCell(Text(person.phoneNumber ?? 'phone')),
                DataCell(
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsChart(person,)));
                      // Action to be performed on button click
                      print('Button clicked for ${person.name}');
                    },
                    child: Text('Click Here',style: TextStyle(color: Colors.white),),
                  ),
                ),
              ]);
            }).toList(),
          ),
        );
      },
    );
  }
}
