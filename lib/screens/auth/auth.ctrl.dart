import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:freshbasket/config/urls.dart';
import 'package:freshbasket/models/userModel.dart';
import 'package:freshbasket/utils/snackbarWidget.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final int pinLength = 4;
  final int maxLength = 10;
  final int maxSeconds = 60;
  RxBool userSignedIn = false.obs;
  String otp = "";
  String? uid = "";
  String? phone = "";
  UserModel? userModel;

  TextEditingController pinController = TextEditingController();
  TextEditingController phoneNumbercontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPhoneController = TextEditingController();
  TextEditingController forgotOTPController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();
  TextEditingController forgotConfirmPasswordController =
  TextEditingController();

  // final TextEditingController pincontroller = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordNewController = TextEditingController();
  final storage = FlutterSecureStorage();

  @override
  void onInit() {
    isUserLoggedIn();
    super.onInit();
  }

  Future<bool> checkPhoneNumber() async {
    if (phoneNumbercontroller.value.text.length != maxLength) {
      return false;
    }
    otp =
    await AuthProvider().checkPhoneNumber(phoneNumbercontroller.value.text);
    return true;
  }

  isUserLoggedIn() async {
    uid = await storage.read(key: 'uid');
    phone = await storage.read(key: 'phone');
    userSignedIn.value = (uid != "" && uid != null) ? true : false;
    if (userSignedIn.value == true && uid != null && phone != null) {
      var userDetails = await AuthProvider().fetchUser(uid!, phone!);
      userModel = UserModel.fromMap(userDetails);
    }
  }

  logoutUser() async {
    if (uid == "") return;
    await storage.delete(key: 'uid');
    userSignedIn.value = false;
    uid = "";
  }

  otpVerify() async {
    if (pinController.value.text.length != pinLength) return;
    var result = await AuthProvider()
        .verifyOtp(pinController.value.text, phoneNumbercontroller.value.text);
    if (result != "") Get.toNamed('/registerUser');
  }

  registerUser(String pincode, String area) async {
    if (passwordController.text
        .trim()
        .length < 8) {
      errorSnackBar("Error", "Password is Less than 8 Characters");
      return;
    }

    if (nameController.text
        .trim()
        .length < 3) {
      errorSnackBar("Error", "Name is Less than 3 Characters");
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      errorSnackBar("Error", "Not a Valid Email Address");
      return;
    }
    var result = await AuthProvider().registerUser(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
        pincode,
        area,
        phoneNumbercontroller.value.text);
    if (result != "") {
      redirectUser(result);
    } else
      errorSnackBar("Error", "User Not registered, Try Again");
  }

  redirectUser(String _result) async {
    await storage.write(key: 'uid', value: _result);
    await storage.write(key: 'phone', value: phoneNumbercontroller.value.text);
    uid = _result;
    userSignedIn.value = true;
    var userDetails =
    await AuthProvider().fetchUser(uid!, phoneNumbercontroller.value.text);
    userModel = UserModel.fromMap(userDetails);
    print(userModel);
    if (userModel != null) Get.toNamed('/home');
  }

  loginUser() async {
    if (phoneNumbercontroller.value.text
        .trim()
        .length != 10) return;
    if (passwordController.value.text
        .trim()
        .length < 8) return;
    var result = await AuthProvider().loginUser(
      phoneNumbercontroller.value.text.trim(),
      passwordController.text.trim(),
    );
    if (result != "") {
      await redirectUser(result);
    } else
      errorSnackBar("Error", "Invalid Login Details");
  }

  Future<bool> forgetPhoneNumber() async {
    if (forgotPhoneController.value.text
        .trim()
        .length != 10) return false;
    otp = await AuthProvider().forgetPhoneNumber(
      forgotPhoneController.value.text.trim(),
    );
    phone = forgotPhoneController.value.text;
    return true;
  }

  Future<bool> forgetPhoneNumberWithOTP() async {
    print("insddd");
    if (forgotOTPController.value.text.trim() == "") return false;
    uid = await AuthProvider().forgetPhoneNumberWithOTP(
      phone!,
      forgotOTPController.value.text.trim(),
    );
    return true;
  }

  Future<bool> resetPassword() async {
    if (forgotPasswordController.value.text
        .trim()
        .length < 8) return false;
    if (forgotConfirmPasswordController.value.text
        .trim()
        .length < 8)
      return false;
    return await AuthProvider().resetPassword(
      forgotPasswordController.value.text.trim(),
      forgotConfirmPasswordController.value.text.trim(),
      phone!,
      uid!,
    );
  }
}

class AuthProvider extends GetConnect {
  Future loginUser(String phonenumber, String password) async {
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['updatenewuser'],
        "userMethod": "loginExistUser",
        "phonenumber": phonenumber,
        "userPassword": password
      };
      final response = await httpClient.request(
          UrlList.endpoints!['updatenewuser'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result['uid'];
      } else
        errorSnackBar("Error", "Improper details");
    } on Exception catch (_) {
      print(_);
      errorSnackBar("Error", "Something went wrong");
    }
    return "";
  }

  Future<String> forgetPhoneNumber(String phonenumber) async {
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['forgetpass'],
        "type": "forgetPasswordOtp",
        "phonenumber": phonenumber,
      };
      final response = await httpClient.request(
          UrlList.endpoints!['createnewuser'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      print(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 201) {
        var result = jsonDecode(response.body);
        print(result['otp']);
        return result['otp'].toString();
      } else if (response.statusCode == 203) {
        var result = jsonDecode(response.body);
        errorSnackBar("Error", result['message'].toString());
        return "";
      }
    } on Exception catch (_) {
      print(_);
      errorSnackBar("Error", "Something went wrong");
    }
    return "";
  }

  Future<bool> resetPassword(String password, String conPassword, String phone,
      String uid) async {
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['forgetpass'],
        "type": "resetPassword",
        "phonenumber": phone,
        "uid": uid,
        "password": password,
        "confirmpassword": conPassword,
      };
      final response = await httpClient.request(
          UrlList.endpoints!['createnewuser'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      print(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return true;
      } else if (response.statusCode == 203) {
        var result = jsonDecode(response.body);
        errorSnackBar("Error", result['message'].toString());
        return false;
      }
    } on Exception catch (_) {
      print(_);
      errorSnackBar("Error", "Something went wrong");
    }
    return false;
  }

  Future<String> forgetPhoneNumberWithOTP(String phonenumber,
      String otp) async {
    print("insd");
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['forgetpass'],
        "type": "verifyforgetPasswordOtp",
        "phonenumber": phonenumber,
        "otp": otp,
      };
      final response = await httpClient.request(
          UrlList.endpoints!['createnewuser'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      print(jsonDecode(response.body));
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result['uid']);
        return result['uid'].toString();
      } else if (response.statusCode == 203) {
        var result = jsonDecode(response.body);
        errorSnackBar("Error", result['message'].toString());
        return "";
      }
    } on Exception catch (_) {
      print(_);
      errorSnackBar("Error", "Something went wrong");
    }
    return "";
  }

  Future fetchUser(String uid, String phonenumber) async {
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['updatenewuser'],
        "userMethod": "fetchUserDetails",
        "phonenumber": phonenumber,
        "uid": uid
      };
      final response = await httpClient.request(
          UrlList.endpoints!['updatenewuser'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        return result;
      } else
        errorSnackBar("Error", "Improper details");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return "";
  }

  Future<String> registerUser(String name, String email, String password,
      String pincode, String area, String phone) async {
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['updatenewuser'],
        "userMethod": "updateNewUser",
        "userName": name,
        "userEmail": email,
        "userPassword": password,
        "userPincode": pincode,
        "location": area,
        "phonenumber": phone,
        "fcmToken": "fcmkey"
      };
      final response = await httpClient.request(
          UrlList.endpoints!['updatenewuser'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        var result = jsonDecode(response.body);
        return result["uid"];
      } else
        errorSnackBar("Error", "Improper details");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return "";
  }

  Future<String> checkPhoneNumber(String phone) async {
    try {
      final response = await httpClient.request(
          UrlList.endpoints!['createnewuser'], "get",
          contentType: "application/json",
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "apikey": UrlList.apikey,
            "requestType": UrlList.requestType['createnewuser'],
            "phonenumber": phone,
            "type": "sendotp"
          });
      print(jsonDecode(response.body));
      if (response.statusCode == 201) {
        var result = jsonDecode(response.body);
        return result['otp'].toString();
      } else if (response.statusCode == 202)
        errorSnackBar("Error", "Phone number already registered, Please login");
    } on Exception catch (_) {
      print(_);
      errorSnackBar("Error", "Something went wrong");
    }
    return "";
  }

  Future<String> verifyOtp(String otpCode, String phone) async {
    try {
      final response = await httpClient.request(
          UrlList.endpoints!['createnewuser'], "post",
          contentType: "application/json",
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "apikey": UrlList.apikey,
            "requestType": UrlList.requestType['createnewuser'],
            "otp": otpCode,
            'phonenumber': phone,
            "type": "verifyotp"
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result['uid'];
      } else
        errorSnackBar("Error", "Invalid Otp Code");
    } on Exception catch (_) {
      errorSnackBar("Error", "Invalid Otp Code");
    }
    return "";
  }
}
