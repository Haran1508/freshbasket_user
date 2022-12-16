// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// class UserController extends GetxController {
//   TextEditingController fName = TextEditingController();
//   TextEditingController lName = TextEditingController();
//   TextEditingController email = TextEditingController();
//   // Rx<UserModel> userModel = UserModel(
//   //   email: '',
//   //   phoneNumber: '',
//   //   name: '',
//   //   walletBalance: '',
//   // ).obs;

//   UserModel? userModel;

//   @override
//   void onInit() {
//     fetchUser();
//     super.onInit();
//   }

//   fetchUser() async {
//     var result;
//     if (result)
//       userModel = UserModel.fromJson(result);
//     else
//       userModel = null;
//   }
// }

// class ApiCall extends GetConnect{

//   Future<Response> getUser() => get(url)
// }

// class UserModel {
//   String userId;
//   String name;
//   String phoneNumber;
//   String email;
//   String walletBalance;

//   UserModel({
//     required this.userId,
//     required this.name,
//     required this.phoneNumber,
//     required this.email,
//     required this.walletBalance,
//   });

//   // UserModel copyWith({
//   // required String userId,
//   // required String name,
//   // required String phoneNumber,
//   // required String email,
//   // required String walletBalance,
//   // }){
//   //   return UserModel(email: (email != null) ? this.email: email , name: name, phoneNumber: phoneNumber, userId: userId, walletBalance:walletBalance);
//   // }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'walletBalance': walletBalance,
//       'userId': userId
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       userId: map['userId'],
//       name: map['name'],
//       phoneNumber: map['phoneNumber'],
//       email: map['email'],
//       walletBalance: map['walletBalance'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source));
// }
