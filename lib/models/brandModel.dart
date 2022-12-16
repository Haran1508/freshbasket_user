import 'dart:convert';

class BrandModel {
  final String image;
  final int brandId;
  final String brandName;
  BrandModel({
    required this.image,
    required this.brandId,
    required this.brandName,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'brandId': brandId,
      'brandName': brandName,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      image: map['image'] ?? '',
      brandId: map['brandId']?.toInt() ?? 0,
      brandName: map['brandName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source));
}
