import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:freshbasket/screens/auth/userlogin.scrn.dart';
import 'package:freshbasket/screens/cart/cart.ctrl.dart';
import 'package:get/get.dart';

import 'deliveryOption.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartController cartController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width) / 100;
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        persistentFooterButtons: [
          if (cartController.total > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width / 2,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    //  color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Text(
                    "Total = Rs ${cartController.total}.00",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: kPrimaryYellow),
                      onPressed: () async {
                        var _uid = authController.uid;
                        if (_uid == null)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserLoginScreen()));
                        else {
                          cartController.onPageStart();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DeliveryOptionScreen()));
                        }
                      },
                      child: Text("Check Out"),
                    ),
                  ),
                )
              ],
            )
        ],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kPrimaryYellow,
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text(
            "Cart Items",
            style: TextStyle(color: kBackgroudColor),
          ),
          leading: goBackButton(),
        ),
        body: (cartController.total > 0) ? CartList() : emptyCart(fontSize));
  }

  Center emptyCart(double fontSize) {
    return Center(
      child: Text(
        "No Items found!",
        style: TextStyle(
          color: Colors.grey,
          fontSize: fontSize * 5.5,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CartList extends StatelessWidget {
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          separatorBuilder: (_, index) => Divider(),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => ListTile(
              leading: Image.network(
                  cartController.cartModel[index].productModel.productImage!),
              title: Text(
                  cartController.cartModel[index].productModel.productName!),
              trailing: Text(
                  "Rs. ${cartController.cartModel[index].count * cartController.cartModel[index].productModel.mrp!}"),
              subtitle: Text(
                  "MRP ${cartController.cartModel[index].productModel.mrp!}   X   ${cartController.cartModel[index].count} No.of Packs")),
          itemCount: cartController.cartModel.length,
        )
      ],
    );
  }

/*
   Container(
          height: 70,
          color: kBackgroudColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('22',
             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
             Text('Sunday',
             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
             
           ],
       ),
        )
  */

}
