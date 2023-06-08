import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_chance_admin/controllers/order_controller.dart';
import 'package:second_chance_admin/models/order_model.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = '\OrderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderController _orderController = OrderController();

  int _currentPage = 1;
  int _maxPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<OrderDataModel>>(
        stream: _orderController.getOrderData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<OrderDataModel>> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final sortedData = List<OrderDataModel>.from(snapshot.data!);
          sortedData.sort((a, b) => b.orderDate.compareTo(a.orderDate));

          final totalItems = sortedData.length;
          final maxPages = (totalItems / _maxPerPage).ceil();
          final startIndex = (_currentPage - 1) * _maxPerPage;
          final endIndex = startIndex + _maxPerPage;
          final displayedData = sortedData.sublist(
              startIndex.clamp(0, totalItems), endIndex.clamp(0, totalItems));

          final dataRows =
              displayedData.map<DataRow>((OrderDataModel orderData) {
            return DataRow(
              cells: [
                DataCell(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: orderData.productImage.isNotEmpty
                      ? Container(
                          height: 50,
                          width: 50,
                          child: Image.network(orderData.productImage[0]))
                      : Text(
                          'No Image',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                )),
                DataCell(Text(
                    DateFormat('dd MMM yyyy hh:mm a').format(
                      orderData.orderDate.toDate(),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    orderData.productName.isNotEmpty
                        ? orderData.productName
                        : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    orderData.status.isNotEmpty ? orderData.status : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    orderData.fullName.isNotEmpty ? orderData.fullName : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
                DataCell(Text(
                    orderData.businessName.isNotEmpty
                        ? orderData.businessName
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
                        'Manage Orders',
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
                          DataColumn(label: Text('IMAGE')),
                          DataColumn(label: Text('ORDER DATE')),
                          DataColumn(label: Text('PRODUCT NAME')),
                          DataColumn(label: Text('STATUS')),
                          DataColumn(label: Text('BUYER NAME')),
                          DataColumn(label: Text('VENDOR NAME')),
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
