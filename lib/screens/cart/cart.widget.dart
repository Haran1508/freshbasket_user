import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:get/get.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            height: Get.height * 0.23,
            color: kPrimaryYellow,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Search groceries, daily needs products",
                  style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryBlack, fontSize: 15, letterSpacing: 1.5),
                  ),
                ),
                Container(
                  height: 45,
                  width: Get.width * 95,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    color: kBackgroudColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("eg: Colgate, Sunflower Oil, etc.."),
                ),
              ],
            ),
          ),
          Spacer(),
          Image.asset(emptyCart),
          Text("Your Cart is Empty !", style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),),
           Spacer(),
        ],
      ),
    );
  }
}