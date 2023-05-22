import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDataModel {
  final String orderId;
  final Timestamp orderDate;
  final String productName;
  final String fullName;
  final String businessName;

  OrderDataModel({
    required this.orderId,
    required this.orderDate,
    required this.productName,
    required this.fullName,
    required this.businessName,
  });

  factory OrderDataModel.fromMap(Map<String, dynamic> map) {
    return OrderDataModel(
      orderId: map['orderId'],
      orderDate: map['orderDate'],
      productName: map['productName'],
      fullName: map['fullName'],
      businessName: map['businessName'],
    );
  }
}
