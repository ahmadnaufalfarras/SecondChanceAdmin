class BannerDataModel {
  final String bannerId;
  final String image;

  BannerDataModel({required this.bannerId, required this.image});

  factory BannerDataModel.fromJson(Map<String, dynamic> data) {
    return BannerDataModel(
      bannerId: data['bannerId'],
      image: data['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bannerId': this.bannerId,
      'image': this.image,
    };
  }
}
