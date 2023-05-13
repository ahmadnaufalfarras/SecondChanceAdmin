import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorScreen extends StatelessWidget {
  static const String routeName = '\VendorScreen';

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('vendors').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataRows =
              snapshot.data!.docs.map<DataRow>((DocumentSnapshot document) {
            final vendorUserData = document.data() as Map<String, dynamic>;
            return DataRow(
              cells: [
                DataCell(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Image.network(vendorUserData['storeImage']),
                  ),
                )),
                DataCell(Text(vendorUserData['businessName'],
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    vendorUserData['cityValue'].toString().toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    vendorUserData['stateValue'].toString().toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    vendorUserData['countryValue']
                        .toString()
                        .split(' ')
                        .last
                        .toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(vendorUserData['approved'] == false
                    ? ElevatedButton(
                        onPressed: () async {
                          await _firestore
                              .collection('vendors')
                              .doc(vendorUserData['vendorId'])
                              .update({
                            'approved': true,
                          });
                        },
                        child: Text('Approved'))
                    : ElevatedButton(
                        onPressed: () async {
                          await _firestore
                              .collection('vendors')
                              .doc(vendorUserData['vendorId'])
                              .update({
                            'approved': false,
                          });
                        },
                        child: Text('Reject')))
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
                    'Manage Vendors',
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
                      DataColumn(label: Text('VENDOR IMAGE')),
                      DataColumn(label: Text('BUSINESS NAME')),
                      DataColumn(label: Text('CITY')),
                      DataColumn(label: Text('STATE')),
                      DataColumn(label: Text('COUNTRY')),
                      DataColumn(label: Text('ACTION')),
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
