import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  Widget orderData(int? flex, Widget widget) {
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
    final Stream<QuerySnapshot> _orderStream =
        FirebaseFirestore.instance.collection('orders').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _orderStream,
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
              final OrderUserData = snapshot.data!.docs[index];
              print(OrderUserData.data());
              return Container(
                child: Row(
                  children: [
                    orderData(
                        2,
                        Text(OrderUserData['orderId'],
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    orderData(
                        2,
                        Text(
                            DateFormat('dd MMM yyyy hh:mm a')
                                .format(OrderUserData['orderDate'].toDate()),
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    orderData(
                        2,
                        Text(OrderUserData['productId'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    orderData(
                        2,
                        Text(OrderUserData['buyerId'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    orderData(
                        2,
                        Text(OrderUserData['vendorId'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              );
            });
      },
    );
  }
}
