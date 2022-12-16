import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/screens/addresses/pincode.ctrl.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RegisterUserScreen extends StatelessWidget {
  PincodeController pincodeController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroudColor,
      body: SingleChildScrollView(
        child: Container(
          height: sizeSettings.fullHeight,
          width: sizeSettings.fullWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kToolbarHeight - 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  appName,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryYellow),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                child: Text(
                  "welcomes you!",
                  style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryYellow.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Please provide your valid information"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                child: Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 15, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: TextField(
                    controller: authController.nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      labelStyle: TextStyle(color: kPrimaryYellow),
                      focusColor: kPrimaryYellow,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryYellow)),
                      border: OutlineInputBorder(),
                      labelText: "Enter your display name",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  bottom: 4,
                ),
                child: Text(
                  "Email Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 15, right: 8),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: TextField(
                    controller: authController.emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      labelStyle: TextStyle(color: kPrimaryYellow),
                      focusColor: kPrimaryYellow,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryYellow)),
                      border: OutlineInputBorder(),
                      labelText: "Enter your email address",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  bottom: 4,
                ),
                child: Text(
                  "Password (minimum 8 Alphanumberic characters)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 8, right: 8),
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: authController.passwordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      labelStyle: TextStyle(color: kPrimaryYellow),
                      focusColor: kPrimaryYellow,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryYellow)),
                      border: OutlineInputBorder(),
                      labelText: "Enter your password",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 6.0,
                  left: 8.0,
                  bottom: 4,
                ),
                child: Text(
                  "Pincode",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 8, right: 8),
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      labelStyle: TextStyle(color: kPrimaryYellow),
                      focusColor: kPrimaryYellow,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryYellow)),
                      border: OutlineInputBorder(),
                      labelText: pincodeController.selectPincode.toString(),
                      //hintText: pincodeController.selectPincode.toString(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 6.0,
                  left: 8.0,
                  bottom: 4,
                ),
                child: Text(
                  "Location",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 8, right: 8),
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      labelStyle: TextStyle(color: kPrimaryYellow),
                      focusColor: kPrimaryYellow,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryYellow)),
                      border: OutlineInputBorder(),
                      //labelText: pincodeController.selectedArea.toString(),
                      hintText: pincodeController.selectedArea.toString(),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.07,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: kPrimaryYellow),
                    onPressed: () async {
                      await authController.registerUser(
                          pincodeController.selectPincode.toString(),
                          pincodeController.selectedArea.toString());
                    },
                    child: Text("Compelete".toUpperCase()),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
