import 'package:flutter/material.dart';
import 'package:second_chance_admin/widgets/buyer_widget.dart';

class BuyerScreen extends StatelessWidget {
  static const String routeName = '\BuyersScreen';

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
        ));
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
              'Manager Buyers',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              _rowHeader('PROFILE IMAGE', 1),
              _rowHeader('FULL NAME', 2),
              _rowHeader('EMAIL', 2),
              _rowHeader('PHONE NUMBER', 2),
              _rowHeader('ADDRESS', 2),
            ],
          ),
          BuyerWidget(),
        ],
      ),
    );
  }
}
