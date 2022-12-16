import 'dart:convert';

class CategoriesModel {
  final int catId;
  final String image;
  final String catName;

  CategoriesModel({
    required this.catId,
    required this.catName,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'image': image,
      'catName': catName,
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      catId: map['catId']?.toInt() ?? 0,
      image: map['image'] ?? '',
      catName: map['catName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesModel.fromJson(String source) =>
      CategoriesModel.fromMap(json.decode(source));
}
