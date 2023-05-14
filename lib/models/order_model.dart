import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDataModel {
  final String orderId;
  final Timestamp orderDate;
  final String productId;
  final String buyerId;
  final String vendorId;

  OrderDataModel({
    required this.orderId,
    required this.orderDate,
    required this.productId,
    required this.buyerId,
    required this.vendorId,
  });

  factory OrderDataModel.fromMap(Map<String, dynamic> map) {
    return OrderDataModel(
      orderId: map['orderId'],
      orderDate: map['orderDate'],
      productId: map['productId'],
      buyerId: map['buyerId'],
      vendorId: map['vendorId'],
    );
  }
}
