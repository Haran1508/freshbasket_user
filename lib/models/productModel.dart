import 'dart:convert';

class ProductModel {
  final int? productCode;
  final String? productImage;
  final String? productName;
  final int? stock;
  final int? catId;
  final int? brandId;
  final int? mrp;
  ProductModel({
    this.productCode,
    this.productImage,
    this.productName,
    this.stock,
    this.catId,
    this.brandId,
    this.mrp,
  });

  Map<String, dynamic> toMap() {
    return {
      'productCode': productCode,
      'productImage': productImage,
      'productName': productName,
      'stock': stock,
      'catId': catId,
      'brandId': brandId,
      'mrp': mrp,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productCode: map['productCode']?.toInt(),
      productImage: map['productImage'],
      productName: map['productName'],
      stock: map['stock']?.toInt(),
      catId: map['catId']?.toInt(),
      brandId: map['brandId']?.toInt(),
      mrp: map['mrp']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
