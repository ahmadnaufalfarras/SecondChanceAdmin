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
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 1;
  int _maxPerPage = 10;

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

          final sortedData = List<BuyerDataModel>.from(snapshot.data!);
          sortedData.sort((a, b) =>
              a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));

          final totalItems = sortedData.length;
          final maxPages = (totalItems / _maxPerPage).ceil();
          final startIndex = (_currentPage - 1) * _maxPerPage;
          final endIndex = startIndex + _maxPerPage;
          final displayedData = sortedData.sublist(
              startIndex.clamp(0, totalItems), endIndex.clamp(0, totalItems));

          final dataRows =
              displayedData.map<DataRow>((BuyerDataModel buyerData) {
            return DataRow(
              cells: [
                DataCell(Flexible(
                  child: Text(
                      buyerData.fullName.isNotEmpty ? buyerData.fullName : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      buyerData.bankName.isNotEmpty ? buyerData.bankName : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      buyerData.bankAccountName.isNotEmpty
                          ? buyerData.bankAccountName
                          : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      buyerData.bankAccountNumber.isNotEmpty
                          ? buyerData.bankAccountNumber
                          : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Center(
                      child: Expanded(
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: DataTable(
                              headingRowColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey.shade200),
                              columns: const [
                                DataColumn(
                                  label: SizedBox(
                                    child: Text('BUYER NAME'),
                                    width: 250,
                                  ),
                                ),
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('BANK NAME'),
                                  width: 250,
                                )),
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('BANK ACCOUNT NAME'),
                                  width: 250,
                                )),
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('BANK ACCOUNT NUMBER'),
                                  width: 250,
                                )),
                              ],
                              rows: dataRows,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: _currentPage > 1
                              ? () {
                                  setState(() {
                                    _currentPage--;
                                  });
                                }
                              : null,
                        ),
                        Text(
                          'Page $_currentPage of $maxPages',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: _currentPage < maxPages
                              ? () {
                                  setState(() {
                                    _currentPage++;
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
