import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/screens/brands/brandlist.ctrl.dart';
import 'package:freshbasket/screens/cart/cart.ctrl.dart';
import 'package:freshbasket/screens/home/home.ctrl.dart';
import 'package:freshbasket/screens/productList/productList.ldr.dart';

import 'cartItem.scrn.dart';

// ignore: must_be_immutable
class BrandProductListScreen extends StatelessWidget {
  CartController cartController = Get.put(CartController());
  HomeController _homeController = Get.find();
  BrandController brandController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      persistentFooterButtons: [
        Obx(
          () => (cartController.productsCodeList.length > 0)
              ? Container(
                  width: sizeSettings.fullWidth * 0.95,
                  padding: EdgeInsets.only(left: 10, bottom: 3, top: 3),
                  decoration: BoxDecoration(
                      color: kPrimaryGreen,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: kBackgroudColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: VerticalDivider(
                          width: 2,
                          color: kBackgroudColor,
                          indent: 8,
                          endIndent: 8,
                        ),
                      ),
                      Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${cartController.productsCodeList.length} item",
                              style: TextStyle(color: kBackgroudColor),
                            ),
                            Text(
                              "Rs. ${cartController.total}",
                              style: TextStyle(
                                  color: kBackgroudColor, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(primary: Colors.white),
                        onPressed: () {
                          Get.offNamed('/cart');
                        },
                        child: Row(
                          children: [
                            Text("Proceed to cart",
                                style: TextStyle(color: kBackgroudColor)),
                            Icon(Icons.keyboard_arrow_right_rounded,
                                color: kBackgroudColor)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        )
      ],
      appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: kBackgroudColor),
          ),
          elevation: 0.0,
          backgroundColor: kPrimaryYellow,
          brightness: Brightness.dark,
          title: Text(
            brandController.selectedBrand.brandName,
            style: TextStyle(color: kBackgroudColor),
          ),
          actions: [
            InkWell(
              onTap: () => Get.toNamed('/search'),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.search, color: kBackgroudColor),
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.filter_list, color: kBackgroudColor),
                onPressed: () {})
          ]),
      body: Obx(
        () => (_homeController.loading.value)
            ? ProductListLoader()
            : ListView.builder(
                controller: _homeController.listScrollcontroller,
                itemCount: _homeController.productsList.length,
                itemBuilder: (context, index) =>
                    CardItem(productModel: _homeController.productsList[index]),
              ),
      ),
    );
  }
}
