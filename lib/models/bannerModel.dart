import 'dart:convert';

class BannerModel {
  final String image;
  final String search;
  BannerModel({
    required this.image,
    required this.search,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'search': search,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      image: map['image'] ?? '',
      search: map['search'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));
}
