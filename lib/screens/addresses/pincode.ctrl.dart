import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:freshbasket/config/urls.dart';
import 'package:freshbasket/models/pincodeModel.dart';
import 'package:freshbasket/utils/snackbarWidget.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PincodeController extends GetxController {
  final int pincodeLength = 6;
  TextEditingController pincodeController = TextEditingController();
  RxList<PincodeModel> pincodeList = <PincodeModel>[].obs;
  late SharedPreferences prefs;
  int? selectPincode;
  String? selectedArea;

  getDevicePincode() async {
    if (!await Geolocator().isLocationServiceEnabled()) {
      Geolocator().checkGeolocationPermissionStatus();
    } else {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      pincodeController.text = first.postalCode;
      verifyPincode();
    }
  }

  verifyPincode() async {
    if (pincodeController.text.trim().length != pincodeLength) return;
    pincodeList.value = await PincodeApiProvider()
        .checkPincode(int.parse(pincodeController.text.trim()));
  }

  setPincodeAndArea(String area, int pincode) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('pincode', pincode);
    prefs.setString('area', area);
  }

  getPincodeAndArea() async {
    prefs = await SharedPreferences.getInstance();
    selectPincode = prefs.getInt('pincode');
    selectedArea = prefs.getString('area');
    if (selectPincode != null) Get.toNamed('/home');
  }

  @override
  void onInit() {
    getPincodeAndArea();
    super.onInit();
  }
}

class PincodeApiProvider extends GetConnect {
  Future checkPincode(int pincode) async {
    List<PincodeModel> pincodes = [];
    try {
      final response = await httpClient.request(
          UrlList.endpoints!['pincode'], "get",
          contentType: "application/json",
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "apikey": UrlList.apikey,
            "requestType": UrlList.requestType['getpincodes'],
            "pincode": pincode
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result as List;
        data.forEach((element) => pincodes.add(PincodeModel.fromMap(element)));
        return pincodes;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return pincodes;
  }
}
