import 'package:flutter/material.dart';
import 'package:second_chance_admin/widgets/order_widget.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '\OrdersScreen';
  Widget _rowHeader(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700),
          color: Colors.yellow.shade900,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Orders',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              _rowHeader('ORDER ID', 2),
              _rowHeader('ORDER DATE', 2),
              _rowHeader('PRODUCT ID', 2),
              _rowHeader('BUYER ID', 2),
              _rowHeader('VENDOR ID', 2),
            ],
          ),
          OrderWidget(),
        ],
      ),
    );
  }
}
