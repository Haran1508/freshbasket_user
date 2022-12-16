import 'dart:convert';

class PincodeModel {
  final int id;
  final String area;
  final int pincode;
  PincodeModel({
    required this.id,
    required this.area,
    required this.pincode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'area': area,
      'pincode': pincode,
    };
  }

  factory PincodeModel.fromMap(Map<String, dynamic> map) {
    return PincodeModel(
      id: map['id']?.toInt() ?? 0,
      area: map['area'] ?? '',
      pincode: map['pincode']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PincodeModel.fromJson(String source) =>
      PincodeModel.fromMap(json.decode(source));
}
