import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WithdrawalScreen extends StatelessWidget {
  static const String routeName = '\WithdrawalScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('withdrawal').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataRows =
              snapshot.data!.docs.map<DataRow>((DocumentSnapshot document) {
            final withdrawalUserData = document.data() as Map<String, dynamic>;
            return DataRow(
              cells: [
                DataCell(Text(
                  withdrawalUserData['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalUserData['amount'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalUserData['bankName'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalUserData['bankAccountName'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalUserData['bankAccountNumber'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalUserData['mobile'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
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
                    'Manage Withdrawal',
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
                      DataColumn(label: Text('NAME')),
                      DataColumn(label: Text('AMOUNT')),
                      DataColumn(label: Text('BANK NAME')),
                      DataColumn(label: Text('BANK ACCOUNT')),
                      DataColumn(label: Text('BANK NUMBER')),
                      DataColumn(label: Text('MOBILE')),
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
