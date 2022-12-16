import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/screens/cart/cart.ctrl.dart';
import 'package:freshbasket/screens/orders_and_offers/order.ctrl.dart';
import 'package:get/get.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  CartController cartController = Get.find();
  OrderListController orderListController = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroudColor,
      body: Column(
        children: [
          Spacer(),
          Icon(
            Icons.check_circle_rounded,
            color: kPrimaryYellow,
            size: size.width * 0.35,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Your order has been placed successfully",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
          Container(
            alignment: Alignment.center,
            width: size.width,
            child: Obx(
              () => Text(
                "Order ID: #${cartController.orderid.value}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: size.width / 2.1,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white24,
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  primary: kPrimaryYellow.withOpacity(0.5),
                  side: BorderSide(color: kPrimaryYellow),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                orderListController.setSelectedOrderId(
                    cartController.orderid.value.toString());
                Get.toNamed('/trackorder');
              },
              child: Text(
                "Track Order",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: kPrimaryYellow),
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: size.width / 2.1,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: kPrimaryYellow,
                  elevation: 0.0),
              onPressed: () {
                Get.toNamed('/home');
              },
              child: Text(
                "Go To Home",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
