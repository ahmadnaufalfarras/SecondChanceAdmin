class CategoryDataModel {
  final String image;
  final String categoryName;

  CategoryDataModel({required this.categoryName, required this.image});

  factory CategoryDataModel.fromJson(Map<String, dynamic> data) {
    return CategoryDataModel(
      image: data['image'],
      categoryName: data['categoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': this.image,
      'categoryName': this.categoryName,
    };
  }
}
