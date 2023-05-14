class WithdrawalDataModel {
  final String name;
  final int amount;
  final String bankName;
  final String bankAccountName;
  final String bankAccountNumber;
  final String mobile;

  WithdrawalDataModel({
    required this.name,
    required this.amount,
    required this.bankName,
    required this.bankAccountName,
    required this.bankAccountNumber,
    required this.mobile,
  });

  factory WithdrawalDataModel.fromMap(Map<String, dynamic> map) {
    return WithdrawalDataModel(
      name: map['name'] ?? '-',
      amount: map['amount'] ?? 0,
      bankName: map['bankName'] ?? '-',
      bankAccountName: map['bankAccountName'] ?? '-',
      bankAccountNumber: map['bankAccountNumber'] ?? '-',
      mobile: map['mobile'] ?? '-',
    );
  }
}
