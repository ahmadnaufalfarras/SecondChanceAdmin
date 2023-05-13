import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '\OrderScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataRows =
              snapshot.data!.docs.map<DataRow>((DocumentSnapshot document) {
            final orderUserData = document.data() as Map<String, dynamic>;
            return DataRow(
              cells: [
                DataCell(Text(orderUserData['orderId'],
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    DateFormat('dd MMM yyyy hh:mm a')
                        .format(orderUserData['orderDate'].toDate()),
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(orderUserData['productId'],
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(orderUserData['buyerId'],
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(orderUserData['vendorId'],
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
                    'Manage Orders',
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
                      DataColumn(label: Text('ORDER ID')),
                      DataColumn(label: Text('ORDER DATE')),
                      DataColumn(label: Text('PRODUCT ID')),
                      DataColumn(label: Text('BUYER ID')),
                      DataColumn(label: Text('VENDOR ID')),
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
