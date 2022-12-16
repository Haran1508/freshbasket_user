import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:freshbasket/config/urls.dart';
import 'package:freshbasket/models/generalsettingsModel.dart';
import 'package:freshbasket/screens/home/home.ctrl.dart';
import 'package:freshbasket/utils/snackbarWidget.dart';
import 'package:get/get.dart';
import 'package:freshbasket/models/productModel.dart';
import 'package:flutter/material.dart';

class CartController extends GetxService {
  HomeController homeController = Get.find();
  RxInt total = 0.obs;
  RxList<CartAddModel> cartModel = <CartAddModel>[].obs;
  RxList<int> productsCodeList = <int>[].obs;
  RxString address = "".obs;
  RxInt orderid = 0.obs;
  Rx<String> selectedDeliveryDate = "".obs;
  late TimeSlots selectedDeliveryTime;

  Rx<int> selectedPayment = 1.obs;

  TextEditingController remarkController = TextEditingController();

  setPaymentOption(int value) {
    selectedPayment.value = value;
  }

  setDeliveryDate(String deliveryDate) {
    selectedDeliveryDate.value = deliveryDate;
  }

  setDeliveryTimeSlot(TimeSlots deliveryTime) {
    selectedDeliveryTime = deliveryTime;
  }

  int itemCount(int productId) {
    int count = 0;
    if (productsCodeList.contains(productId))
      cartModel.forEach((element) {
        if (element.productModel.productCode == productId) {
          count = element.count;
        }
      });
    return count;
  }

  totalAmount(int productId, [bool add = false]) {
    int localtotal = 0;
    for (int m = 0; m < cartModel.length; m++) {
      localtotal += cartModel[m].count * cartModel[m].productModel.mrp!;
    }
    total.value = localtotal;
    //total = (add) ? (total + localtotal) : (total - localtotal);
  }

  removeproductFromCart(int productId, ProductModel productModel) {
    if (productsCodeList.length > 0 && productsCodeList.contains(productId)) {
      for (int j = 0; j < cartModel.length; j++) {
        if (cartModel[j].productModel.productCode == productId) {
          if (cartModel[j].count > 1) {
            int newCount = cartModel[j].count - 1;
            cartModel.remove(cartModel[j]);
            cartModel
                .add(CartAddModel(productModel: productModel, count: newCount));
            return;
          } else {
            productsCodeList.remove(cartModel[j].productModel.productCode);
            cartModel.remove(cartModel[j]);
          }
        }
      }
    }
  }

  addproductTocart(int productId, ProductModel productModel) {
    List<CartAddModel> fullList = [];
    if (productsCodeList.contains(productId)) {
      for (int i = 0; i < cartModel.length; i++) {
        if (cartModel[i].productModel.productCode == productId) {
          int newCount = cartModel[i].count + 1;
          fullList
              .add(CartAddModel(productModel: productModel, count: newCount));
        } else {
          fullList.add(cartModel[i]);
        }
      }
      cartModel.clear();
      cartModel.addAll(fullList);
    } else {
      cartModel.add(CartAddModel(productModel: productModel, count: 1));
      productsCodeList.add(productId);
    }
  }

  placeOrder(Map data) async {
    var response = await PlaceOrderApi().orderPlacement(data);
    if (response == null)
      errorSnackBar("Error", "Something went wrong");
    else {
      orderid.value = response;
      productsCodeList.clear();
      cartModel.clear();
      Get.toNamed('/thankyou');
    }
  }

  onPageStart() {
    if (homeController.generalSettings.value.deliveryDates != null) {
      setDeliveryDate(homeController.generalSettings.value.deliveryDates![0]);
      setDeliveryTimeSlot(homeController.generalSettings.value.timeSlots![0]);
    }
  }


// @override
// void onInit() {
//   setDeliveryDate(homeController.generalSettings.value.deliveryDates![0]);
//   setDeliveryTimeSlot(homeController.generalSettings.value.timeSlots![0]);
//   super.onInit();
// }

// @override
// void onReady() {
//   super.onReady();
//   if (homeController.generalSettings.value.deliveryDates != null) {
//     setDeliveryDate(homeController.generalSettings.value.deliveryDates![0]);
//     setDeliveryTimeSlot(homeController.generalSettings.value.timeSlots![0]);
//   }
// }
}

class PlaceOrderApi extends GetConnect {
  Future orderPlacement(Map orderDetails) async {
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['placeorder'],
        "subrequestType": "placeOrder",
        "orderdetails": orderDetails
      };
      final response = await httpClient.request(
          UrlList.endpoints!['orders'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      print("success");
      print(response.body);
      if (response.statusCode == 201) {
        var result = jsonDecode(response.body);
        return result['orderid'];
      }
    } on Exception catch (e) {
      print("error");
      debugPrint(e.toString());
      return null;
    }
  }
}

class CartAddModel {
  ProductModel productModel;
  int count;

  CartAddModel({
    required this.productModel,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'productModel': productModel.toMap(),
      'count': count,
    };
  }

  factory CartAddModel.fromMap(Map<String, dynamic> map) {
    return CartAddModel(
      productModel: ProductModel.fromMap(map['productModel']),
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartAddModel.fromJson(String source) =>
      CartAddModel.fromMap(json.decode(source));
}
