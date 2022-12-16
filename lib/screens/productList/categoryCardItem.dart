// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/models/productModel.dart';
import 'package:freshbasket/screens/cart/cart.ctrl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCardItem extends StatefulWidget {
  final ProductModel productModel;

  CategoryCardItem({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  _CategoryCardItemState createState() => _CategoryCardItemState();
}

class _CategoryCardItemState extends State<CategoryCardItem> {
  CartController cartController = Get.find();

  Widget addRemoveButton(int cartIndex, BuildContext context) {
    int itemCount = cartController.itemCount(widget.productModel.productCode!);
    return Container(
      height: 42,
      width: Get.width / 4,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Material(
          color: Colors.transparent,
          child: Card(
            elevation: 5,
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: kPrimaryYellow,
                      ),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        cartController.removeproductFromCart(
                            widget.productModel.productCode!,
                            widget.productModel);
                        itemCount = cartController
                            .itemCount(widget.productModel.productCode!);
                        cartController
                            .totalAmount(widget.productModel.productCode!);
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Obx(
                      () => Text(
                          (cartController.productsCodeList
                                  .contains(widget.productModel.productCode))
                              ? itemCount.toString()
                              : "0",
                          style: TextStyle(color: kPrimaryYellow)),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Icon(
                        Icons.add,
                        size: 18,
                        color: kPrimaryYellow,
                      ),
                      onPressed: () {
                        cartController.addproductTocart(
                            widget.productModel.productCode!,
                            widget.productModel);
                        itemCount = cartController
                            .itemCount(widget.productModel.productCode!);
                        cartController.totalAmount(
                            widget.productModel.productCode!, true);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeSettings.fullWidth,
      height: sizeSettings.fullHeight * 0.2,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade400, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            child: Stack(
              children: [
                Container(
                  width: sizeSettings.fullWidth / 4,
                  height: sizeSettings.fullWidth / 4,
                  margin: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      if (widget.productModel.stock! > 0)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                              placeholder: appLogoGrey,
                              image: widget.productModel.productImage!),
                        ),
                      if (widget.productModel.stock == 0) ...{
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                Colors.grey,
                                BlendMode.saturation,
                              ),
                              child: Image.network(
                                  widget.productModel.productImage!),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            color: Colors.grey.shade300,
                            width: sizeSettings.fullWidth / 4,
                            height: 20,
                            child: Text("Out Of Stack"),
                          ),
                        )
                      }
                    ],
                  ),
                ),
                if (widget.productModel.stock! > 0) offerPercentWidget(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: sizeSettings.fullWidth * 0.8,
                  child: Text(
                    widget.productModel.productName!,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "₹ ${widget.productModel.mrp} Mrp",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                    Spacer(),
                    if (widget.productModel.stock! < 6 &&
                        widget.productModel.stock! > 0) ...{
                      itemLeftInStock(),
                    }
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.productModel.stock! > 0) ...{
                      if (cartController.productsCodeList
                          .contains(widget.productModel.productCode)) ...{
                        addRemoveButton(
                            widget.productModel.productCode!, context)
                      } else
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                primary: kPrimaryYellow,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {
                              cartController.addproductTocart(
                                  widget.productModel.productCode!,
                                  widget.productModel);
                              cartController.totalAmount(
                                  widget.productModel.productCode!, true);
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 20),
                                  child: Text(
                                    "ADD",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    },
                    SizedBox()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned offerPercentWidget() {
    return Positioned(
      right: 0,
      child: Container(
        height: 25,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: kPrimaryGreen,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )),
        child: Text(
          "15 % Off",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kBackgroudColor,
              fontSize: 11),
        ),
      ),
    );
  }

  Container itemLeftInStock() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      decoration: BoxDecoration(
        color: kPrimaryRed.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: kPrimaryRed.withOpacity(0.5), width: 1),
      ),
      child: Text(
        " " + widget.productModel.stock.toString() + "  left in stock",
        style: TextStyle(fontWeight: FontWeight.w600, color: kPrimaryRed),
      ),
    );
  }
}
