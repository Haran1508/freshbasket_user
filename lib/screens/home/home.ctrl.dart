import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freshbasket/config/urls.dart';
import 'package:freshbasket/models/bannerModel.dart';
import 'package:freshbasket/models/branchModel.dart';
import 'package:freshbasket/models/brandModel.dart';
import 'package:freshbasket/models/categoryModel.dart';
import 'package:freshbasket/models/generalsettingsModel.dart';
import 'package:freshbasket/models/productModel.dart';
import 'package:freshbasket/utils/snackbarWidget.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList bannerList = [].obs;
  RxList<CategoriesModel> categories = <CategoriesModel>[].obs;
  RxList<BrandModel> brands = <BrandModel>[].obs;
  RxList<Branches> branches = <Branches>[].obs;
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  RxList<ProductModel> catProductsList = <ProductModel>[].obs;
  RxBool loading = true.obs;
  RxBool homeLoading = true.obs;
  RxInt itemCount = 10.obs;
  ScrollController listScrollcontroller = ScrollController();
  late GlobalKey<ScaffoldState> scaffoldKey;
  Rx<GeneralSettings> generalSettings =
      GeneralSettings(deliveryDates: [], timeSlots: [], paymentModes: []).obs;

  @override
  void onInit() {
    super.onInit();
    listScrollcontroller = ScrollController()..addListener(scrollListener);
    scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: '_homeScreenkey');
    fetchHomeScreenData();
  }

  scrollListener() {
    if (listScrollcontroller.position.extentAfter < 15) {
      if (itemCount < productsList.length)
        itemCount.value = itemCount.value + 10;
      else {
        if (listScrollcontroller.position.userScrollDirection ==
            ScrollDirection.reverse) Get.snackbar("", "No More Items");
      }
    }
  }

  @override
  void dispose() {
    listScrollcontroller.dispose();
    super.dispose();
  }

  searchClick() => Get.toNamed('/search');

  fetchHomeScreenData() async {
    homeLoading.value = true;
    bannerList.value = await HomeRepository().fetchBanners();
    categories.value = await HomeRepository().fetchCategories();
    brands.value = await HomeRepository().fetchBrands();
    branches.value = await HomeRepository().fetchBranches();
    generalSettings.value = await HomeRepository().fetchGeneralSettings();
    Future.delayed(Duration(seconds: 2), () {}).then((value) {
      if (generalSettings.value.deliveryDates != null)
        homeLoading.value = false;
      else
        homeLoading.value = true;
    });
  }

  fetchBrandProducts(int brandId) async {
    if (brandId > 0) {
      Timer(Duration(seconds: 2), () {
        loading.value = false;
      });
      productsList.value =
          await HomeRepository().fetchBrandProductsList(brandId);
      loading.value = true;
    }
  }

  fetchCategoryProducts(int catId) async {
    if (catId > 0) {
      Timer(Duration(seconds: 2), () {
        loading.value = false;
      });
      catProductsList.value =
          await HomeRepository().fetchCategoryProductsList(catId);
      loading.value = true;
    }
  }

  getToken() async {
    //var token = await HomeRepository().fetchAccessToken();
    //print(token);
  }
}

class HomeRepository extends GetConnect {
  Future fetchGeneralSettings() async {
    GeneralSettings generalSettings;
    try {
      final response = await httpClient.request(
        UrlList.endpoints!['generalsettings'],
        "post",
        contentType: "application/json",
        headers: {'Accept': 'application/json'},
        body: {
          "apikey": UrlList.apikey,
          "requestType": "namgeneralsettingsrequest"
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        generalSettings = GeneralSettings.fromJson(result);
        return generalSettings;
      } else
        return "";
    } on Exception catch (_) {
      return "";
    }
  }

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
        if (productsList.length > 0) {
          productsList.sort((a, b) => a.stock!.compareTo(b.stock!));
          return productsList.reversed.toList();
        }
        return productsList;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return productsList;
  }

  Future fetchCategoryProductsList(int catId) async {
    List<ProductModel> _productsList = [];
    try {
      final response = await httpClient.request(
        UrlList.endpoints!['products'],
        "post",
        contentType: "application/json",
        headers: {'Accept': 'application/json'},
        body: {
          "apikey": UrlList.apikey,
          "requestType": "fetchproductsbyCategory",
          "catId": catId
        },
      );
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result["products"] as List;
        data.forEach(
            (element) => _productsList.add(ProductModel.fromMap(element)));
        if (_productsList.length > 0) {
          _productsList.sort((a, b) => a.stock!.compareTo(b.stock!));
          return _productsList.reversed.toList();
        }
        return _productsList;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      print(_);
      errorSnackBar("Error", "Something went wrong");
    }
    return _productsList;
  }

  Future fetchBrands() async {
    List<BrandModel> brands = [];
    try {
      final response = await httpClient.request(
        UrlList.endpoints!['brands'],
        "post",
        contentType: "application/json",
        headers: {'Accept': 'application/json'},
        body: {
          "apikey": UrlList.apikey,
          "requestType": UrlList.requestType['getbrands']
        },
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result["brands"] as List;
        data.forEach((element) => brands.add(BrandModel.fromMap(element)));
        return brands;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return brands;
  }

  Future fetchBranches() async {
    List<Branches> _branches = [];
    try {
      final response = await httpClient.request(
        UrlList.endpoints!['branches'],
        "post",
        contentType: "application/json",
        headers: {'Accept': 'application/json'},
        body: {
          "apikey": UrlList.apikey,
          "requestType": UrlList.requestType['getbranches']
        },
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result as List;
        data.forEach((element) => _branches.add(Branches.fromMap(element)));
        return _branches;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return _branches;
  }

  Future fetchCategories() async {
    List<CategoriesModel> categories = [];
    print("key " + UrlList.apikey);
    try {
      final response = await httpClient.request(
          UrlList.endpoints!['category'], "post",
          contentType: "application/json",
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "apikey": UrlList.apikey,
            "requestType": UrlList.requestType['getcategories']
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result as List;
        data.forEach(
            (element) => categories.add(CategoriesModel.fromMap(element)));
        return categories;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return categories;
  }

  Future<List<BannerModel>> fetchBanners() async {
    List<BannerModel> banners = [];
    try {
      final response = await httpClient.request(
          UrlList.endpoints!['banners'], "post",
          contentType: "application/json",
          headers: {
            'Accept': 'application/json'
          },
          body: {
            "apikey": UrlList.apikey,
            "requestType": UrlList.requestType['getbanners']
          });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var data = result as List;
        data.forEach((element) => banners.add(BannerModel.fromMap(element)));
        return banners;
      } else
        errorSnackBar("Error", "Something went wrong");
    } on Exception catch (_) {
      errorSnackBar("Error", "Something went wrong");
    }
    return banners;
  }

  Future fetchAccessToken() async {}
}
