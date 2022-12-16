import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:freshbasket/screens/orders_and_offers/order.ctrl.dart';
import 'package:get/get.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  // AddressController addressController = Get.put(AddressController());
  OrderListController orderListController = Get.put(OrderListController());

  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  fetchOrders() async {
    await orderListController.fetchOrderList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width) / 100;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kPrimaryYellow,
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text(
            "Orders List",
            style: TextStyle(color: kBackgroudColor),
          ),
          leading: goBackButton(),
        ),
        body: Obx(() => orderListController.orderLsit.length == 0
            ? onOrdersWidget(fontSize)
            : orderListWidgte()));
  }

  Widget orderListWidgte() {
    return ListView.separated(
        itemCount: orderListController.orderLsit.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (_, index) => Divider(
              thickness: 1,
            ),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              orderListController.setSelectedOrderId(
                  orderListController.orderLsit[index].orderid.toString());
              Get.toNamed('/trackorder');
            },
            isThreeLine: true,
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                orderListController.orderLsit[index].orderdate,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.black87),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Order ID : #" +
                      orderListController.orderLsit[index].orderid.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    orderListController.orderLsit[index].orderstatus
                        .toString()
                        .capitalizeFirst!,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.green)),
                Text(
                    "Rs : " +
                        orderListController.orderLsit[index].amount.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black)),
              ],
            ),
          );
        });
    // return Text("Check");
  }

  Center onOrdersWidget(double fontSize) {
    return Center(
      child: Text(
        "No orders found!",
        style: TextStyle(
          color: Colors.grey,
          fontSize: fontSize * 5.5,
        ),
      ),
    );
  }
}
