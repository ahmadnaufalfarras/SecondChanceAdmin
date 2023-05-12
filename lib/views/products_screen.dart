import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '\ProductScreen';

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataRows =
              snapshot.data!.docs.map<DataRow>((DocumentSnapshot document) {
            final productsData = document.data() as Map<String, dynamic>;
            return DataRow(
              cells: [
                DataCell(Container(
                  height: 50,
                  width: 50,
                  child: Image.network(productsData['image']),
                )),
                DataCell(Text(
                  productsData['productName'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  productsData['productPrice'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  productsData['category'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(productsData['approved'] == false
                    ? ElevatedButton(
                        onPressed: () async {
                          await _firestore
                              .collection('products')
                              .doc(productsData['productId'])
                              .update({
                            'approved': true,
                          });
                        },
                        child: Text('Approved'))
                    : ElevatedButton(
                        onPressed: () async {
                          await _firestore
                              .collection('products')
                              .doc(productsData['productId'])
                              .update({
                            'approved': false,
                          });
                        },
                        child: Text('Reject'))),
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
                    'Manage Products',
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
                      DataColumn(label: Text('IMAGE')),
                      DataColumn(label: Text('PRODUCT NAME')),
                      DataColumn(label: Text('PRODUCT PRICE')),
                      DataColumn(label: Text('CATEGORY')),
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
