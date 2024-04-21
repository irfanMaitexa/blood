import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('bloodBank').where('status',isEqualTo: 0).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        // String  userId = FirebaseAuth.instance.currentUser!.uid;

        List<QueryDocumentSnapshot> users = snapshot.data!.docs.map((doc) {
        

          // if(data['userId'] == userId ){}
          return doc;
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: [
              DataColumn(label: Text('SL No.')),
              DataColumn(label: Text('Bloodgp')),
              DataColumn(label: Text('Age')),
              DataColumn(label: Text('Status')),

            ],
            rows: users.map((data) {

              var person = data.data() as Map<String,dynamic>;
              return DataRow(cells: [
                DataCell(Text(person['userId'])),
                DataCell(Text(person['bloodGroup'] ?? 'blood')),
                DataCell(Text(person['age'] ?? 'age')),
            
                DataCell(
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      

                      FirebaseFirestore.instance.collection('bloodBank').doc(data.id).update({
                         'status':1
                      });



                      
                      
                    },
                    child: Text('Accept',style: TextStyle(color: Colors.white),),
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
