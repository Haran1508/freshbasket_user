import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'auth.Widgets.dart';

// ignore: must_be_immutable
class VerifyOtpScreen2 extends StatelessWidget {
  AuthController authController = Get.put(AuthController());

  //final authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.50,
              width: Get.width,
              color: kBackgroudColor,
              child: Column(
                children: [
                  SizedBox(height: sizeSettings.blockWidth * 10),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Enter Verification Code",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: kPrimaryBlack),
                    ),
                  ),
                  Container(
                    height: Get.width * 0.38,
                    width: Get.width * 0.38,
                    decoration: BoxDecoration(
                        color: kPrimaryYellow.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(100)),
                    child: Image.asset(
                      icMb1,
                      color: kPrimaryBlack.withOpacity(0.8),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Enter OTP",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryBlack))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "We have sent OTP to your number \n +91 8778619412",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                ClipPath(
                  clipper: ClipBackGround(70),
                  child: Container(
                    height: Get.height * 0.50,
                    width: Get.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          kPrimaryYellow.withOpacity(0.8),
                          kPrimaryYellow
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                ),
                ClipPath(
                  clipper: ClipBackGround(45),
                  child: Container(
                    height: Get.height * 0.50,
                    width: Get.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          kPrimaryYellow.withOpacity(0.5),
                          kPrimaryYellow
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: sizeSettings.blockWidth * 30),
                    Container(
                      height: 60,
                      width: Get.width * 0.95,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PinInputTextField(
                          pinLength: authController.pinLength,
                          controller: authController.pinController,
                          onChanged: (value) {
                            //if (value.length == 4) otpVerify(context, value);
                          },
                          keyboardType: TextInputType.number,
                          decoration: BoxLooseDecoration(
                              strokeColorBuilder: PinListenColorBuilder(
                                  kPrimaryBlack, kPrimaryBlack),
                              strokeWidth: 1,
                              radius: Radius.circular(5),
                              bgColorBuilder: PinListenColorBuilder(
                                  Colors.white, Colors.grey.shade300)),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't receive the OTP ?",
                          style:
                              TextStyle(color: kPrimaryYellow.withOpacity(0.7)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                                color: kPrimaryYellow,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: sizeSettings.blockWidth * 8)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: Get.width * 0.5,
                        height: Get.height * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 5.0,
                              primary: kPrimaryRed,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          onPressed: () {
                            Get.offNamed('/registerUser');
                          },
                          child: Text(
                            "VERIFY OTP",
                            style: TextStyle(
                                color: kBackgroudColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VerifyOtpDesign(),
    );
  }
}

// ignore: must_be_immutable
class VerifyOtpDesign extends StatelessWidget {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroudColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: Get.height * 0.1)),
            Container(
              height: Get.width * 0.35,
              width: Get.width * 0.35,
              decoration: BoxDecoration(
                  color: kPrimaryYellow.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                Icons.phone_android_outlined,
                color: kPrimaryYellow,
                size: sizeSettings.blockWidth * 25,
              ),
            ),
            Text(
              "OTP Verification - " + authController.otp,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: (Get.width / 100) * 5),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter the OTP send to    ",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "+91 " + authController.phoneNumbercontroller.text,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: (sizeSettings.fontSize * 4.5)),
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              width: Get.width * 0.95,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PinInputTextField(
                  pinLength: authController.pinLength,
                  controller: authController.pinController,
                  onChanged: (value) {
                    if (value.length == 4) authController.otpVerify();
                  },
                  keyboardType: TextInputType.number,
                  decoration: BoxLooseDecoration(
                      strokeColorBuilder:
                          PinListenColorBuilder(Colors.green, Colors.red),
                      strokeWidth: 1.5,
                      radius: Radius.circular(5),
                      bgColorBuilder: PinListenColorBuilder(
                          Colors.white, Colors.grey.shade300)),
                  // decoration: BoxLooseDecoration(
                  //   solidColor: Colors.white10,
                  //   enteredColor: Colors.red,
                  //   gapSpace: 10,
                  //   strokeColor: Colors.black26,
                  //   radius: Radius.circular(5),
                  //   textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  // ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Don't receive the OTP ?"),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(color: kPrimaryBlack),
                  ),
                ),
                SizedBox(
                  width: sizeSettings.blockWidth * 5,
                )
              ],
            ),
            SizedBox(height: sizeSettings.blockWidth * 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryYellow),
                  onPressed: () {
                    // Get.offNamed('/registerUser');
                    authController.otpVerify();
                  },
                  child: Text("VERIFY"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
