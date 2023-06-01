class VendorDataModel {
  final String storeImage;
  final String businessName;
  final String email;
  final String vendorAddress;
  final String vendorPostalCode;
  final String phoneNumber;
  final String vendorBankName;
  final String vendorBankAccountName;
  final String vendorBankAccountNumber;
  final bool approved;
  final String vendorId;

  VendorDataModel({
    required this.storeImage,
    required this.businessName,
    required this.email,
    required this.vendorAddress,
    required this.vendorPostalCode,
    required this.phoneNumber,
    required this.vendorBankName,
    required this.vendorBankAccountName,
    required this.vendorBankAccountNumber,
    required this.approved,
    required this.vendorId,
  });

  factory VendorDataModel.fromMap(Map<String, dynamic> map) {
    return VendorDataModel(
      storeImage: map['storeImage'] ?? '-',
      businessName: map['businessName'] ?? '-',
      email: map['email'] ?? '-',
      vendorAddress: map['vendorAddress'] ?? '-',
      vendorPostalCode: map['vendorPostalCode'] ?? '-',
      phoneNumber: map['phoneNumber'] ?? '-',
      vendorBankName: map['vendorBankName'] ?? '-',
      vendorBankAccountName: map['vendorBankAccountName'] ?? '-',
      vendorBankAccountNumber: map['vendorBankAccountNumber'] ?? '-',
      approved: map['approved'] ?? false,
      vendorId: map['vendorId'] ?? '-',
    );
  }
}
