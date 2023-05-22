import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_chance_admin/controllers/order_controller.dart';
import 'package:second_chance_admin/models/order_model.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '\OrderScreen';

  final OrderController _orderController = OrderController();

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

          final dataRows =
              snapshot.data!.map<DataRow>((OrderDataModel orderData) {
            return DataRow(
              cells: [
                DataCell(Text(
                    orderData.orderId.isNotEmpty ? orderData.orderId : '-',
                    style: TextStyle(fontWeight: FontWeight.bold))),
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
                      DataColumn(label: Text('ORDER ID')),
                      DataColumn(label: Text('ORDER DATE')),
                      DataColumn(label: Text('PRODUCT NAME')),
                      DataColumn(label: Text('BUYER NAME')),
                      DataColumn(label: Text('VENDOR NAME')),
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
