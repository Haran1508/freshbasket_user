import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:freshbasket/models/generalsettingsModel.dart';
import 'package:freshbasket/screens/addresses/pincode.ctrl.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:freshbasket/screens/cart/cart.ctrl.dart';
import 'package:freshbasket/screens/home/home.ctrl.dart';
import 'package:freshbasket/utils/loaderWidget.dart';
import 'package:freshbasket/utils/snackbarWidget.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// ignore: must_be_immutable
class DeliveryOptionScreen extends StatefulWidget {
  DeliveryOptionScreen({Key? key}) : super(key: key);

  @override
  _DeliveryOptionScreenState createState() => _DeliveryOptionScreenState();
}

class _DeliveryOptionScreenState extends State<DeliveryOptionScreen> {
  CartController cartController = Get.find();
  AuthController authController = Get.find();
  PincodeController pincodeController = Get.find();
  HomeController homeController = Get.find();

  String Name = "Place Order";

  Container textFieldContainer(
      {required BuildContext context,
      required String hintText,
      bool trailing = false,
      IconData endIcon = Icons.visibility}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.15),
                spreadRadius: 4,
                blurRadius: 5)
          ]),
      child: Obx(
        () => TextFormField(
          cursorHeight: 22,
          initialValue: cartController.address.value,
          maxLines: 5,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              suffixIcon: AbsorbPointer(
                absorbing: (trailing == true) ? false : true,
                child: Material(
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      endIcon,
                      color:
                          (trailing == true) ? Colors.grey : Colors.transparent,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }

  editAddressDialog(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Row(
              children: [
                Spacer(),
                Text(
                  "Edit Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                )
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Builder(
              builder: (context) => Container(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    textFieldContainer(context: context, hintText: "Address"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: Get.width,
                        height: Get.height * 0.07,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: kPrimaryYellow),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Save Address"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  bool showLoader = false;
  static const platform = const MethodChannel("razorpay_flutter");
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: true,
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    cartController.productsCodeList.clear();
                    cartController.cartModel.clear();
                    Get.toNamed('/home');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10, right: 20, left: 20),
                    child: Text(
                      "Cancel Order",
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryYellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    if (cartController.address.isEmpty) {
                      errorSnackBar(
                          "Error", "Please Enter your delivery address");
                      return;
                    }
                    setState(() {
                      showLoader = true;
                    });
                    Future.delayed(Duration(seconds: 5), () {
                      showLoader = false;
                      setState(() {});
                    });
                    if (homeController
                            .generalSettings
                            .value
                            .paymentModes![cartController.selectedPayment.value]
                            .paymentMode ==
                        "ONLINE PAYMENT") {
                      openCheckout();
                    } else {
                      postValues("");
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10, right: 20, left: 20),
                    child: Text(
                      "${Name}",
                      style: TextStyle(color: kBackgroudColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: kPrimaryYellow,
            brightness: Brightness.dark,
            centerTitle: true,
            title: Text(
              "Checkout",
              style: TextStyle(color: kBackgroudColor),
            ),
            leading: goBackButton(),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleWidget("Dellivery Address"),
                  Obx(
                    // ignore: unrelated_type_equality_checks
                    () => (cartController.address == "")
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                onPressed: () => Get.toNamed('/addNewAddress'),
                                child: Text(
                                  "Add New Address",
                                  style: TextStyle(color: kPrimaryYellow),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryYellow),
                                onPressed: () =>
                                    Get.toNamed('/existingAddress'),
                                child: Text(
                                  "Choose Exist Address",
                                  style: TextStyle(color: kBackgroudColor),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.location_city),
                                ),
                                Expanded(
                                  child: Text(cartController.address.value),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    editAddressDialog(context);
                                  },
                                  icon: Icon(Icons.edit, color: kPrimaryYellow),
                                  label: Text(
                                    "Edit",
                                    style: TextStyle(color: kPrimaryYellow),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                  titleWidget("Delivery Date"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Obx(
                      () => DropdownButton(
                          focusColor: Colors.transparent,
                          // value: cartController.selectedDeliveryDate.value??"",
                          iconSize: 30,
                          iconEnabledColor: kPrimaryYellow,
                          underline: Container(
                            color: kPrimaryYellow,
                            //height: size.blockSizeVertical * 0.08,
                          ),
                          dropdownColor: Colors.grey.shade200,
                          isExpanded: true,
                          elevation: 2,
                          hint: Text(cartController.selectedDeliveryDate.value),
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                            fontWeight:
                                (cartController.selectedDeliveryDate.value ==
                                        "")
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                          ),
                          items: homeController
                              .generalSettings.value.deliveryDates!
                              .map<DropdownMenuItem<String>>((date) {
                            return DropdownMenuItem<String>(
                                child: Text(
                                  date,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                                value: date);
                          }).toList(),
                          onChanged: (dateValue) {
                            cartController
                                .setDeliveryDate(dateValue.toString());
                            setState(() {});
                          }),
                    ),
                  ),
                  titleWidget("Delivery Time Slot"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Obx(
                      () => DropdownButton(
                          focusColor: Colors.transparent,
                          value: cartController.selectedDeliveryTime,
                          iconSize: 30,
                          iconEnabledColor: kPrimaryYellow,
                          underline: Container(
                            color: kPrimaryYellow,
                          ),
                          dropdownColor: Colors.grey.shade200,
                          isExpanded: true,
                          elevation: 2,
                          hint: Text("Choose Delivery Time"),
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                            fontWeight:
                                (cartController.selectedDeliveryTime.timing ==
                                        "")
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                          ),
                          items: homeController.generalSettings.value.timeSlots!
                              .map<DropdownMenuItem<TimeSlots>>(
                                  (timeSlotValue) {
                            return DropdownMenuItem<TimeSlots>(
                                child: Text(
                                  timeSlotValue.timing!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                                value: timeSlotValue);
                          }).toList(),
                          onChanged: (timeSlotValue) {
                            cartController.setDeliveryTimeSlot(
                                timeSlotValue as TimeSlots);
                            setState(() {});
                          }),
                    ),
                  ),
                  titleWidget("Payment Method"),
                  Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: homeController
                          .generalSettings.value.paymentModes!
                          .map((e) {
                        return RadioListTile(
                          activeColor: kPrimaryYellow,
                          value: homeController
                              .generalSettings.value.paymentModes!
                              .indexOf(e),
                          groupValue: cartController.selectedPayment.value,
                          dense: false,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (value) {
                            cartController.setPaymentOption(
                              int.parse(value.toString()),
                            );
                            if (int.parse(value.toString()) == 2) {
                              Name = "Pay Now";
                            } else {
                              Name = "Place Order";
                            }
                            setState(() {});
                          },
                          title: Text(e.paymentMode!),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    color: kPrimaryYellow.withOpacity(0.1),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Total Amount = Rs. ${cartController.total}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: kPrimaryYellow),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  addressTitle("Delivery Instruction"),
                  addressInputBox(
                      context,
                      TextField(
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          controller: cartController.remarkController,
                          maxLines: 4,
                          decoration: inputDecoration("Notes"))),
                  Container(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Amount Due - Rs. ${cartController.total}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryBlack,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      color: kPrimaryRed.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Order Now and Save Rs. 37.00 !!!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kBackgroudColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
        if (showLoader) LoaderWidget()
      ],
    );
  }

  Padding addressInputBox(BuildContext context, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 8, right: 8),
      child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: child),
    );
  }

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      labelStyle: TextStyle(color: kPrimaryYellow),
      focusColor: kPrimaryYellow,
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: kPrimaryYellow)),
      border: OutlineInputBorder(),
      labelText: hintText,
      //hintText: pincodeController.selectPincode.toString(),
    );
  }

  Padding addressTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 6.0,
        left: 8.0,
        bottom: 4,
      ),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  postValues(String value) {
    Map<String, dynamic> source = {};
    source["uid"] = authController.uid;
    source['selected_pincode'] = pincodeController.selectPincode;
    source['selected_area'] = pincodeController.selectedArea;
    source['address'] = cartController.address.value;
    source['deliveryDate'] = cartController.selectedDeliveryDate.value;
    source['deliveryTime'] = cartController.selectedDeliveryTime;
    source['items_count'] = cartController.cartModel[0].count;
    source['total_amount'] = cartController.total.value;
    source['paymentMode'] = homeController.generalSettings.value
        .paymentModes![cartController.selectedPayment.value].paymentMode;
    //.paymentOptions[cartController.selectedPayment.value - 1];
    source['products'] = cartController.cartModel.toList();
    source['payment_id'] = value;
    source['deliveryinstruction'] = cartController.remarkController.text;
    cartController.placeOrder(source);
  }

  Container titleWidget(String title) {
    return Container(
      width: Get.width,
      color: Colors.grey.shade200,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Text(title),
    );
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_s7kpjERJ0Oc4Un',
      'amount': cartController.total.value * 100,
      'name': '${authController.userModel!.name}',
      'description': 'Create Order',
      'retry': {'enabled': true, 'max_count': 5},
      'send_sms_hash': true,
      'prefill': {
        'contact': '${authController.userModel!.phonenumber}',
        'email': '${authController.userModel!.email}'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Success: " + response.paymentId!);
    postValues(response.paymentId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR: " + response.code.toString() + " - " + response.message!);
    errorSnackBar("Error", "Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("EXTERNAL_WALLET: " + response.walletName!);
  }
}
