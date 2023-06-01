import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/vendor_controller.dart';
import 'package:second_chance_admin/models/vendor_model.dart';

class VendorBankScreen extends StatelessWidget {
  static const String routeName = '\VendorBankScreen';

  final VendorBankController _vendorBankController = VendorBankController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<VendorDataModel>>(
        stream: _vendorBankController.getVendorData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<VendorDataModel>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataRows =
              snapshot.data!.map<DataRow>((VendorDataModel vendorData) {
            return DataRow(
              cells: [
                DataCell(Text(
                    vendorData.businessName.isNotEmpty
                        ? vendorData.businessName
                        : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    vendorData.vendorBankName.isNotEmpty
                        ? vendorData.vendorBankName
                        : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    vendorData.vendorBankAccountName.isNotEmpty
                        ? vendorData.vendorBankAccountName
                        : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    vendorData.vendorBankAccountNumber.isNotEmpty
                        ? vendorData.vendorBankAccountNumber
                        : '-',
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
                    'Manage Vendors Bank',
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
                      DataColumn(label: Text('BUSINESS NAME')),
                      DataColumn(label: Text('BANK NAME')),
                      DataColumn(label: Text('BANK ACCOUNT NAME')),
                      DataColumn(label: Text('BANK ACCOUNT NUMBER')),
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
