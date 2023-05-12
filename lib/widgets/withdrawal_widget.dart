import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WithdrawalWidget extends StatelessWidget {
  const WithdrawalWidget({super.key});

  Widget withdrawalData(int? flex, Widget widget) {
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
    final Stream<QuerySnapshot> _withdrawalStream =
        FirebaseFirestore.instance.collection('withdrawal').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _withdrawalStream,
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
              final withdrawalUserData = snapshot.data!.docs[index];
              return Container(
                child: Row(
                  children: [
                    withdrawalData(
                        1,
                        Text(
                          withdrawalUserData['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    withdrawalData(
                        2,
                        Text(withdrawalUserData['amount'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    withdrawalData(
                        2,
                        Text(withdrawalUserData['bankName'],
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    withdrawalData(
                        2,
                        Text(withdrawalUserData['bankAccountName'],
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    withdrawalData(
                        2,
                        Text(withdrawalUserData['bankAccountNumber'],
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    withdrawalData(
                        2,
                        Text(withdrawalUserData['mobile'],
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              );
            });
      },
    );
  }
}
