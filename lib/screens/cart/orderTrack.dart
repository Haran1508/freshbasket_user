import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/screens/orders_and_offers/order.ctrl.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  OrderListController orderListController = Get.find();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await orderListController
        .fetchSelectedOrder(orderListController.selectedOderId.value);
    print(orderListController.selectedOrder.value.amount);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Order"),
        centerTitle: true,
        backgroundColor: kPrimaryYellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                height: 45,
                width: size.width,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Order ID: #${orderListController.selectedOrder.value
                            .orderid}"),
                    Text(
                      "Rs: ${orderListController.selectedOrder.value.amount}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                height: 120,
                width: size.width,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 5,
                          spreadRadius: 1)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Deliver to",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Flexible(
                      child: Text(
                        "${orderListController.selectedOrder.value
                            .deliveryAddress}",
                        overflow: TextOverflow.clip,
                        maxLines: 4,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              ExpansionTile(
                collapsedBackgroundColor: Colors.grey.shade300,
                iconColor: kPrimaryYellow,
                collapsedTextColor: kPrimaryYellow,
                collapsedIconColor: kPrimaryYellow,
                initiallyExpanded: false,
                textColor: kPrimaryYellow,
                title: Text(
                  "Order Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.image, size: 45),
                        title: Text(
                            "${orderListController.selectedOrder.value
                                .orderdetails![index].productname}"),
                        trailing: Text(
                            "${orderListController.selectedOrder.value
                                .orderdetails![index].productprice}"),
                      );
                    },
                    shrinkWrap: true,
                    itemCount:
                    (orderListController.selectedOrder.value.orderdetails !=
                        null)
                        ? orderListController
                        .selectedOrder.value.orderdetails!.length
                        : 0,
                  ),
                  Divider(thickness: 1.5),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Total Amount"),
                    trailing: Text(
                        "Rs: ${orderListController.selectedOrder.value
                            .amount}"),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Delivery Charge"),
                    trailing: Text("Rs.10"),
                  ),
                  Divider(thickness: 1.5),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Amount to be paid"),
                    trailing: Text("Rs.110"),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                color: Colors.grey.shade300,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "Order Delivery Status",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    top: size.height * 0.07,
                    left: size.width * 0.023,
                    child: Container(
                      width: 1.5,
                      height: 300,
                      color: Colors.grey,
                    ),
                  ),
                  Column(
                    children: [
                      stepperWidget(
                          size,
                          "Order Placed",
                          "${orderListController.selectedOrder.value
                              .placedtime}",
                          (orderListController.selectedOrder.value.placedtime !=
                              0)
                              ? true
                              : false),
                      stepperWidget(
                          size,
                          "Order Accepted",
                          "${orderListController.selectedOrder.value
                              .acceptedtime}",
                          (orderListController
                              .selectedOrder.value.acceptedtime !=
                              0)
                              ? true
                              : false),
                      stepperWidget(
                          size,
                          "Order Packed",
                          "${orderListController.selectedOrder.value
                              .packedtime}",
                          (orderListController.selectedOrder.value.packedtime !=
                              0)
                              ? true
                              : false),
                      stepperWidget(
                          size,
                          "Order Out for Delivery",
                          "${orderListController.selectedOrder.value
                              .outfordeliverytime}",
                          (orderListController
                              .selectedOrder.value.outfordeliverytime !=
                              0)
                              ? true
                              : false),
                      stepperWidget(
                          size,
                          "Delivered",
                          "${orderListController.selectedOrder.value
                              .deliveredtime}",
                          (orderListController
                              .selectedOrder.value.deliveredtime !=
                              0)
                              ? true
                              : false),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding stepperWidget(Size size, String title, String date, bool completed) {
    // DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            color: Colors.white,
            child: Icon(
              (completed) ? Icons.check_circle : Icons.circle,
              size: 20,
              color: (completed) ? Colors.green : Colors.grey.shade500,
            ),
          ),
          Spacer(),
          Container(
            height: 60,
            width: size.width * 0.85,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.3),
              ),
            ),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: (completed) ? Colors.green : Colors.black54),
              ),
              subtitle: (completed)
                  ? Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.grey,
                    size: 12,
                  ),
                  Text(
                    "${date}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )
                  : Text(""),
            ),
          )
        ],
      ),
    );
  }
}
