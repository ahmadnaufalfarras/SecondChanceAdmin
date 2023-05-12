import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  Widget productData(int? flex, Widget widget) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream =
        FirebaseFirestore.instance.collection('products').snapshots();

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final productUserData = snapshot.data!.docs[index];
              print(productUserData.data());
              return Container(
                child: Row(
                  children: [
                    productData(
                        1,
                        Container(
                          height: 50,
                          width: 50,
                          child: Image.network(productUserData['image']),
                        )),
                    productData(
                        3,
                        Text(productUserData['productName'],
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    productData(
                        2,
                        Text(productUserData['productPrice'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    productData(
                        2,
                        Text(productUserData['category'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    productData(
                        1,
                        productUserData['approved'] == false
                            ? ElevatedButton(
                                onPressed: () async {
                                  await _firestore
                                      .collection('products')
                                      .doc(productUserData['productId'])
                                      .update({
                                    'approved': true,
                                  });
                                },
                                child: Text('Approved'))
                            : ElevatedButton(
                                onPressed: () async {
                                  await _firestore
                                      .collection('products')
                                      .doc(productUserData['productId'])
                                      .update({
                                    'approved': false,
                                  });
                                },
                                child: Text('Reject'))),
                  ],
                ),
              );
            });
      },
    );
  }
}
