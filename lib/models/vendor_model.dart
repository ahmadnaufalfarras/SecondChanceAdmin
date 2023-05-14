class VendorDataModel {
  final String storeImage;
  final String businessName;
  final String cityValue;
  final String stateValue;
  final String countryValue;
  final bool approved;
  final String vendorId;

  VendorDataModel({
    required this.storeImage,
    required this.businessName,
    required this.cityValue,
    required this.stateValue,
    required this.countryValue,
    required this.approved,
    required this.vendorId,
  });

  factory VendorDataModel.fromMap(Map<String, dynamic> map) {
    return VendorDataModel(
      storeImage: map['storeImage'] ?? '-',
      businessName: map['businessName'] ?? '-',
      cityValue: map['cityValue'] ?? '-',
      stateValue: map['stateValue'] ?? '-',
      countryValue: map['countryValue'] ?? '-',
      approved: map['approved'] ?? false,
      vendorId: map['vendorId'] ?? '-',
    );
  }
}
