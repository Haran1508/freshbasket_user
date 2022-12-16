import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:get/get.dart';
import 'address.ctrl.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  AddressController addressController = Get.put(AddressController());

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      persistentFooterButtons: [
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
              addressController.saveAddress();
              Get.back();
            },
            child: Text("Save Address"),
          ),
        )
      ],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryYellow,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "Add New Address",
          style: TextStyle(color: kBackgroudColor),
        ),
        leading: goBackButton(),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addressTitle("Name"),
              addressInputBox(
                  context,
                  TextField(
                      controller: addressController.nameController,
                      decoration: inputDecoration("Contact Person"))),
              addressTitle("Land Mark"),
              addressInputBox(
                  context,
                  TextField(
                      controller: addressController.landMarkController,
                      decoration: inputDecoration("Eg: Near Pillaiar Kovil"))),
              addressTitle("Alternate Contact"),
              addressInputBox(
                  context,
                  TextField(
                      controller: addressController.alternateContactController,
                      decoration:
                          inputDecoration("Enter alternate contact number"))),
              addressTitle("Full Address"),
              addressInputBox(
                  context,
                  TextField(
                      controller: addressController.fullAddressController,
                      maxLines: 5,
                      decoration: inputDecoration("Enter full Address"))),
            ],
          ),
        ),
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
