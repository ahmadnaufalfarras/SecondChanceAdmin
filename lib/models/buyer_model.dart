import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerDataModel {
  final String profileImage;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String postalCode;
  final String bankName;
  final String bankAccountName;
  final String bankAccountNumber;
  final Timestamp registeredDate;

  BuyerDataModel({
    required this.profileImage,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.postalCode,
    required this.bankName,
    required this.bankAccountName,
    required this.bankAccountNumber,
    required this.registeredDate,
  });

  factory BuyerDataModel.fromMap(Map<String, dynamic> map) {
    return BuyerDataModel(
      profileImage: map['profileImage'] ?? '-',
      fullName: map['fullName'] ?? '-',
      email: map['email'] ?? '-',
      phoneNumber: map['phoneNumber'] ?? '-',
      address: map['address'] ?? '-',
      postalCode: map['postalCode'] ?? '-',
      bankName: map['bankName'] ?? '-',
      bankAccountName: map['bankAccountName'] ?? '-',
      bankAccountNumber: map['bankAccountNumber'] ?? '-',
      registeredDate: map['registeredDate'] ?? '-',
    );
  }
}
