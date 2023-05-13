import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyerScreen extends StatelessWidget {
  static const String routeName = '\BuyerScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('buyers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataRows =
              snapshot.data!.docs.map<DataRow>((DocumentSnapshot document) {
            final buyerUserData = document.data() as Map<String, dynamic>;
            return DataRow(
              cells: [
                DataCell(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Image.network(buyerUserData['profileImage']),
                  ),
                )),
                DataCell(Text(buyerUserData['fullName'],
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(buyerUserData['email'],
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(buyerUserData['phoneNumber'],
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(buyerUserData['address'],
                    style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            );
          }).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Manage Buyers',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.grey.shade200),
                    columns: const [
                      DataColumn(label: Text('PROFILE IMAGE')),
                      DataColumn(label: Text('FULL NAME')),
                      DataColumn(label: Text('EMAIL')),
                      DataColumn(label: Text('PHONE NUMBER')),
                      DataColumn(label: Text('ADDRESS')),
                    ],
                    rows: dataRows,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
