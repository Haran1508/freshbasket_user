import 'dart:convert';

import 'package:freshbasket/config/urls.dart';
import 'package:freshbasket/models/orderModel.dart';
import 'package:freshbasket/models/selectedOrderModel.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController {
  AuthController authController = Get.find();
  List<OrderModel> orderLsit = <OrderModel>[].obs;
  Rx<String> selectedOderId = "".obs;
  Rx<SelectedOrder> selectedOrder = SelectedOrder().obs;

  setSelectedOrderId(String orderId) {
    selectedOderId.value = orderId;
  }

  fetchSelectedOrder(String id) async {
    selectedOrder.value = await OrderListApi()
        .orderFetchPaticular(authController.uid!, int.parse(id));
  }

  fetchOrderList() async {
    orderLsit = await OrderListApi().orderFetch(authController.uid!);
  }
}

class OrderListApi extends GetConnect {
  Future orderFetch(String uid) async {
    List<OrderModel> orders = [];
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['placeorder'],
        "subrequestType": "getallOrders",
        "uid": uid
      };
      final response = await httpClient.request(
          UrlList.endpoints!['orders'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        result.forEach((element) => orders.add(OrderModel.fromMap(element)));
        return orders;
      }
    } on Exception catch (e) {
      return orders;
    }
  }

  Future orderFetchPaticular(String uid, int orderId) async {
    SelectedOrder selectedOrder;
    try {
      Map body = {
        "apikey": UrlList.apikey,
        "requestType": UrlList.requestType['placeorder'],
        "subrequestType": "checkOrderstatus",
        "uid": uid,
        "orderId": orderId
      };
      final response = await httpClient.request(
          UrlList.endpoints!['orders'], "post",
          contentType: "application/json",
          headers: {'Accept': 'application/json'},
          body: body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        selectedOrder = SelectedOrder.fromJson(result);
        return selectedOrder;
      }
    } on Exception catch (e) {
      return "";
    }
  }
}
