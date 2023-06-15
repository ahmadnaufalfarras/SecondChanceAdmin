import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/buyer_controller.dart';
import 'package:second_chance_admin/models/buyer_model.dart';

class BuyerScreen extends StatefulWidget {
  static const String routeName = '\BuyerScreen';

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
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
                DataCell(Flexible(
                  child: Text(
                      buyerData.fullName.isNotEmpty ? buyerData.fullName : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      buyerData.email.isNotEmpty ? buyerData.email : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      buyerData.phoneNumber.isNotEmpty
                          ? buyerData.phoneNumber
                          : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      buyerData.address.isNotEmpty ? buyerData.address : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      buyerData.postalCode.isNotEmpty
                          ? buyerData.postalCode
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
                                  child: Text('PROFILE IMAGE'),
                                  width: 100,
                                )),
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('FULL NAME'),
                                  width: 200,
                                )),
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('EMAIL'),
                                  width: 250,
                                )),
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('PHONE NUMBER'),
                                  width: 150,
                                )),
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('ADDRESS'),
                                  width: 250,
                                )),
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('POSTAL CODE'),
                                  width: 100,
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
