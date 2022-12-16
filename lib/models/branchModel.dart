import 'dart:convert';

class Branches {
  int branchId;
  String branchName;
  String address;
  String pincode;
  String phoneNumber;
  String landLine;
  Branches({
    required this.branchId,
    required this.branchName,
    required this.address,
    required this.pincode,
    required this.phoneNumber,
    required this.landLine,
  });

  Map<String, dynamic> toMap() {
    return {
      'branchId': branchId,
      'branchName': branchName,
      'address': address,
      'pincode': pincode,
      'phoneNumber': phoneNumber,
      'landLine': landLine,
    };
  }

  factory Branches.fromMap(Map<String, dynamic> map) {
    return Branches(
      branchId: map['branchId']?.toInt() ?? 0,
      branchName: map['branchName'] ?? '',
      address: map['address'] ?? '',
      pincode: map['pincode'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      landLine: map['landLine'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Branches.fromJson(String source) =>
      Branches.fromMap(json.decode(source));
}
