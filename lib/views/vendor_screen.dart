import 'package:flutter/material.dart';
import 'package:second_chance_admin/controllers/vendor_controller.dart';
import 'package:second_chance_admin/models/vendor_model.dart';

class VendorScreen extends StatefulWidget {
  static const String routeName = '\VendorScreen';

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final VendorController _vendorController = VendorController();
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 1;
  int _maxPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<VendorDataModel>>(
        stream: _vendorController.getVendorData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<VendorDataModel>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final sortedData = List<VendorDataModel>.from(snapshot.data!);
          sortedData.sort((a, b) =>
              b.vendorRegisteredDate.compareTo(a.vendorRegisteredDate));

          final totalItems = sortedData.length;
          final maxPages = (totalItems / _maxPerPage).ceil();
          final startIndex = (_currentPage - 1) * _maxPerPage;
          final endIndex = startIndex + _maxPerPage;
          final displayedData = sortedData.sublist(
              startIndex.clamp(0, totalItems), endIndex.clamp(0, totalItems));

          final dataRows =
              displayedData.map<DataRow>((VendorDataModel vendorData) {
            return DataRow(
              cells: [
                DataCell(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: vendorData.storeImage.isNotEmpty
                      ? Container(
                          height: 50,
                          width: 50,
                          child: Image.network(vendorData.storeImage),
                        )
                      : Text(
                          'No Image',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                )),
                DataCell(Flexible(
                  child: Text(
                      vendorData.businessName.isNotEmpty
                          ? vendorData.businessName
                          : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      vendorData.email.isNotEmpty ? vendorData.email : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      vendorData.phoneNumber.isNotEmpty
                          ? vendorData.phoneNumber
                          : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      vendorData.vendorAddress.isNotEmpty
                          ? vendorData.vendorAddress
                          : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(Flexible(
                  child: Text(
                      vendorData.vendorPostalCode.isNotEmpty
                          ? vendorData.vendorPostalCode
                          : '-',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                DataCell(vendorData.approved == false
                    ? ElevatedButton(
                        onPressed: () {
                          _vendorController.approveVendor(vendorData.vendorId);
                        },
                        child: Text('Approve'))
                    : ElevatedButton(
                        onPressed: () {
                          _vendorController.rejectVendor(vendorData.vendorId);
                        },
                        child: Text('Reject')))
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
                        'Manage Vendors',
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
                                  child: Text('VENDOR IMAGE'),
                                  width: 100,
                                )),
                                DataColumn(
                                    label: SizedBox(
                                  child: Text('BUSINESS NAME'),
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
                                DataColumn(label: Text('ACTION')),
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
