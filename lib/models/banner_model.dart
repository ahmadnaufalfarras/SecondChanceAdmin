class BannerDataModel {
  final String image;

  BannerDataModel({required this.image});

  factory BannerDataModel.fromJson(Map<String, dynamic> data) {
    return BannerDataModel(
      image: data['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': this.image,
    };
  }
}
