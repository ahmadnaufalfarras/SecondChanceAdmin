import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/buyer_controller.dart';
import 'package:second_chance_admin/models/buyer_model.dart';

class BuyerScreen extends StatelessWidget {
  static const String routeName = '\BuyerScreen';

  final BuyerController _buyerController = BuyerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<BuyerDataModel>>(
        stream: _buyerController.getBuyerData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<BuyerDataModel>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataRows =
              snapshot.data!.map<DataRow>((BuyerDataModel buyerData) {
            return DataRow(
              cells: [
                DataCell(
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buyerData.profileImage.isNotEmpty
                        ? Container(
                            height: 50,
                            width: 50,
                            child: Image.network(buyerData.profileImage))
                        : Text(
                            'No Image',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                DataCell(Text(
                    buyerData.fullName.isNotEmpty ? buyerData.fullName : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    buyerData.email.isNotEmpty ? buyerData.email : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    buyerData.phoneNumber.isNotEmpty
                        ? buyerData.phoneNumber
                        : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    buyerData.address.isNotEmpty ? buyerData.address : '-',
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
