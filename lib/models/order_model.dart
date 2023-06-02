import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDataModel {
  final List<String> productImage;
  final Timestamp orderDate;
  final String productName;
  final String status;
  final String fullName;
  final String businessName;

  OrderDataModel({
    required this.productImage,
    required this.orderDate,
    required this.productName,
    required this.status,
    required this.fullName,
    required this.businessName,
  });

  factory OrderDataModel.fromMap(Map<String, dynamic> map) {
    return OrderDataModel(
      productImage:
          map['productImage'] != null && map['productImage'].isNotEmpty
              ? List<String>.from(map['productImage'])
              : ['-'],
      orderDate: map['orderDate'] ?? '-',
      productName: map['productName'] ?? '-',
      status: map['status'] ?? '-',
      fullName: map['fullName'] ?? '-',
      businessName: map['businessName'] ?? '-',
    );
  }
}
