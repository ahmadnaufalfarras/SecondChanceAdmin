class BuyerDataModel {
  final String profileImage;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;

  BuyerDataModel({
    required this.profileImage,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory BuyerDataModel.fromMap(Map<String, dynamic> map) {
    return BuyerDataModel(
      profileImage: map['profileImage'] ?? '-',
      fullName: map['fullName'] ?? '-',
      email: map['email'] ?? '-',
      phoneNumber: map['phoneNumber'] ?? '-',
      address: map['address'] ?? '-',
    );
  }
}
