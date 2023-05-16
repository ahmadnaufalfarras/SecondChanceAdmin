class CategoryDataModel {
  final String categoryId;
  final String image;
  final String categoryName;

  CategoryDataModel(
      {required this.categoryId,
      required this.categoryName,
      required this.image});

  factory CategoryDataModel.fromJson(Map<String, dynamic> data) {
    return CategoryDataModel(
      categoryId: data['categoryId'],
      image: data['image'],
      categoryName: data['categoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': this.categoryId,
      'image': this.image,
      'categoryName': this.categoryName,
    };
  }
}
