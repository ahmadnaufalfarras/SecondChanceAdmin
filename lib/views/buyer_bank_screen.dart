import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/buyer_controller.dart';
import 'package:second_chance_admin/models/buyer_model.dart';

class BuyerBankScreen extends StatefulWidget {
  static const String routeName = '\BuyerBankScreen';

  @override
  State<BuyerBankScreen> createState() => _BuyerBankScreenState();
}

class _BuyerBankScreenState extends State<BuyerBankScreen> {
  final BuyerController _buyerController = BuyerController();

  int currentPage = 1;

  int maxPerPage = 10;

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

          final sortedData = snapshot.data!.toList()
            ..sort((a, b) =>
                a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));

          final totalItems = sortedData.length;
          final maxPages = (totalItems / maxPerPage).ceil();
          final startIndex = (currentPage - 1) * maxPerPage;
          final endIndex = startIndex + maxPerPage;
          final displayedData = sortedData.sublist(
              startIndex.clamp(0, totalItems), endIndex.clamp(0, totalItems));

          final dataRows =
              displayedData.map<DataRow>((BuyerDataModel buyerData) {
            return DataRow(
              cells: [
                DataCell(Text(
                    buyerData.fullName.isNotEmpty ? buyerData.fullName : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    buyerData.bankName.isNotEmpty ? buyerData.bankName : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    buyerData.bankAccountName.isNotEmpty
                        ? buyerData.bankAccountName
                        : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    buyerData.bankAccountNumber.isNotEmpty
                        ? buyerData.bankAccountName
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
                        'Manage Buyers Bank',
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
                          DataColumn(label: Text('BUYER NAME')),
                          DataColumn(label: Text('BANK NAME')),
                          DataColumn(label: Text('BANK ACCOUNT NAME')),
                          DataColumn(label: Text('BANK ACCOUNT NUMBER')),
                        ],
                        rows: dataRows,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: currentPage > 1
                              ? () {
                                  setState(() {
                                    currentPage--;
                                  });
                                }
                              : null,
                        ),
                        Text(
                          'Page $currentPage of $maxPages',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: currentPage < maxPages
                              ? () {
                                  setState(() {
                                    currentPage++;
                                  });
                                }
                              : null,
                        ),
                      ],
                    ),
                  ]));
        },
      ),
    );
  }
}
