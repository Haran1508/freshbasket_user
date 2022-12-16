import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshbasket/config/urls.dart';
import 'package:freshbasket/models/productModel.dart';
import 'package:freshbasket/utils/snackbarWidget.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  TextEditingController searchTextController = TextEditingController();
  final RxString searchText = "".obs;
  RxList<ProductModel> result = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  searchFunction(String value) async {
    searchText.value = value;
    debounce(searchText, (value) async {
      result.value = await SearchProvider().searchApi(searchText.value);
    }, time: Duration(seconds: 2));
  }

  List<String> popularSearches = [
    "milk",
    "bread",
    "butter",
    "apple",
    "orange",
    "fruits",
    "Latest Products"
  ];
}

class SearchProvider extends GetConnect {
  Future<List<ProductModel>> searchApi(String query) async {
    List<ProductModel> productsList = [];
    try {
      final response = await httpClient.request(
        UrlList.endpoints!['search'],
        "post",
        contentType: "application/json",
        headers: {'Accept': 'application/json'},
        body: {
          "apikey": UrlList.apikey,
          "requestType": "namsearchrequest",
          "searchQuery": query
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
}
