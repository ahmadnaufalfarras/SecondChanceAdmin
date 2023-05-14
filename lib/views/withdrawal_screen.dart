import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/withdrawal_controller.dart';
import 'package:second_chance_admin/models/withdrawal_model.dart';

class WithdrawalScreen extends StatelessWidget {
  static const String routeName = '\WithdrawalScreen';

  final WithdrawalController _withdrawalController = WithdrawalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<WithdrawalDataModel>>(
        stream: _withdrawalController.getWithdrawalData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<WithdrawalDataModel>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataRows =
              snapshot.data!.map<DataRow>((WithdrawalDataModel withdrawalData) {
            return DataRow(
              cells: [
                DataCell(Text(
                  withdrawalData.name.isNotEmpty ? withdrawalData.name : '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalData.amount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalData.bankName.isNotEmpty
                      ? withdrawalData.bankName
                      : '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalData.bankAccountName.isNotEmpty
                      ? withdrawalData.bankAccountName
                      : '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalData.bankAccountNumber.isNotEmpty
                      ? withdrawalData.bankAccountNumber
                      : '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(Text(
                  withdrawalData.mobile.isNotEmpty
                      ? withdrawalData.mobile
                      : '-',
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
