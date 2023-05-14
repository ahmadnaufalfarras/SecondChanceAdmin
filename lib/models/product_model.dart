class ProductDataModel {
  final String productId;
  final String productName;
  final int productPrice;
  final String category;
  final List<String> imageUrlList;
  final bool approved;

  ProductDataModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.category,
    required this.imageUrlList,
    required this.approved,
  });

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      productId: map['productId'] ?? '-',
      productName: map['productName'] ?? '-',
      productPrice: map['productPrice'] ?? 0,
      category: map['category'] ?? '-',
      imageUrlList:
          map['imageUrlList'] != null && map['imageUrlList'].isNotEmpty
              ? List<String>.from(map['imageUrlList'])
              : ['-'],
      approved: map['approved'] ?? '-',
    );
  }
}
