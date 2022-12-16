import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbasket/config/urls.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:freshbasket/screens/cart/cart.ctrl.dart';
import 'package:freshbasket/utils/snackbarWidget.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController alternateContactController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  List<String> addressList = [];
  RxBool loading = false.obs;
  // String address = "";
  CartController cartController = Get.find();
  AuthController authController = Get.find();
  saveAddress() {
    if (nameController.text.trim() == "") return;
    if (alternateContactController.text.trim() == "") return;
    if (landMarkController.text.trim() == "") return;
    if (fullAddressController.text.trim() == "") return;
    cartController.address.value = nameController.text.trim() +
        "\n" +
        alternateContactController.text.trim() +
        '\n' +
        landMarkController.text.trim() +
        '\n' +
        fullAddressController.text.trim();
  }

  setExistingAddress(String _address) {
    cartController.address.value = _address;
  }

  searchExistAddress() async {
    loading.value = true;
    if (authController.uid != null) {
      addressList = await AddressProvider().searchAddress(authController.uid!);
      loading.value = false;
    } else {
      addressList = [];
      loading.value = false;
    }
  }
}

class AddressProvider extends GetConnect {
  Future searchAddress(String uid) async {
    List<String> addresses = [];
    try {
      final response = await httpClient.request(
        UrlList.endpoints!['address'],
        "post",
        contentType: "application/json",
        headers: {'Accept': 'application/json'},
        body: {
          "apikey": UrlList.apikey,
          "requestType": UrlList.requestType['searchaddress'],
          "uid": uid
        },
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result["addresslist"] as List;
        data.forEach((element) {
          addresses.add(element);
        });
        return addresses;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return addresses;
  }
}


/*
Future<List<ProductModel>> fetchBrandProductsList(int brandId) async {
    List<ProductModel> productsList = [];
    try {
      final response = await httpClient.request(
        UrlList.endpoints!['products'],
        "post",
        contentType: "application/json",
        headers: {'Accept': 'application/json'},
        body: {
          "apikey": UrlList.apikey,
          "requestType": "fetchproductsbyBrand",
          "brandId": brandId
        },
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result["products"] as List;
        data.forEach(
            (element) => productsList.add(ProductModel.fromMap(element)));
        return productsList;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return productsList;
  }
*/