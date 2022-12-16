import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:get/get.dart';
// import 'address.ctrl.dart';

class FeedBackForm extends StatefulWidget {
  const FeedBackForm({Key? key}) : super(key: key);

  @override
  _FeedBackFormState createState() => _FeedBackFormState();
}

class _FeedBackFormState extends State<FeedBackForm> {
  // AddressController addressController = Get.put(AddressController());

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      labelStyle: TextStyle(color: kPrimaryYellow),
      focusColor: kPrimaryYellow,
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: kPrimaryYellow)),
      border: OutlineInputBorder(),
      labelText: hintText,
      //hintText: pincodeController.selectPincode.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryYellow,
        centerTitle: true,
        title: Text(
          "FeedBack",
          style: TextStyle(color: kBackgroudColor),
        ),
        leading: goBackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addressTitle("Name"),
          addressInputBox(
              context,
              TextField(
                  //controller: addressController.nameController,
                  decoration: inputDecoration("Your Name"))),
          addressTitle("Email"),
          addressInputBox(
              context,
              TextField(
                  // controller: addressController.landMarkController,
                  decoration: inputDecoration("Your email address"))),
          addressTitle("Feedback Message"),
          addressInputBox(
              context,
              TextField(
                  //controller: addressController.fullAddressController,
                  maxLines: 5,
                  decoration: inputDecoration("Enter your feedback here"))),
          Spacer(),
          SizedBox(
            width: Get.width,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: () {
                // addressController.saveAddress();
                Get.back();
              },
              child: Text("Submit"),
            ),
          )
        ],
      ),
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
}
