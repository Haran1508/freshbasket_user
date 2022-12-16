import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:get/get.dart';
import 'auth.Widgets.dart';

class PhoneAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SecondLoginDesign(),
    );
  }
}

// ignore: must_be_immutable
class SecondLoginDesign extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroudColor,
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: Get.height * 0.04)),
          Container(
            height: sizeSettings.fullWidth * 0.35,
            width: sizeSettings.fullWidth * 0.35,
            decoration: BoxDecoration(
                color: kPrimaryYellow.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.person,
              color: kPrimaryYellow,
              size: sizeSettings.blockWidth * 25,
            ),
          ),
          Text(
            "Phone Verification",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: (Get.width / 100) * 5),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "You need to register your phone number before getting started !",
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 60,
            width: Get.width * 0.95,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  "+91",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 20,
                    width: 1.5,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: authController.phoneNumbercontroller,
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 2),
                      hintText: "Enter your phone number",
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: (Get.width / 100) * 3.5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: Get.width,
              height: Get.height * 0.07,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: kPrimaryYellow),
                onPressed: () async {
                  bool result = await authController.checkPhoneNumber();
                  if (result) Get.toNamed('/verifyOtp');
                },
                child: Text("GET OTP"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FirstLoginDesign extends StatelessWidget {
  const FirstLoginDesign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Get.height * 0.50,
            width: Get.width,
            color: kBackgroudColor,
            child: Column(
              children: [
                SizedBox(height: sizeSettings.blockWidth * 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "OTP Verification",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: kPrimaryBlack),
                  ),
                ),
                Container(
                  height: Get.width * 0.40,
                  width: Get.width * 0.40,
                  decoration: BoxDecoration(
                      color: kPrimaryYellow.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(100)),
                  child: Image.asset(
                    icMb2,
                    color: kPrimaryBlack.withOpacity(0.5),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Enter valid phone number",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryBlack))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("We will send you a OTP Message"))
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
                          colors: [kPrimaryYellow, kPrimaryYellow],
                          //colors: [kPrimaryBlack.withOpacity(0.8), kPrimaryBlack],
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
                          // colors: [kPrimaryBlack.withOpacity(0.5), kPrimaryBlack],
                          colors: [kPrimaryYellow, kPrimaryYellow],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: sizeSettings.blockWidth * 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 55),
                    child: TextField(
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryBlack)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryBlack.withOpacity(0.8))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryBlack.withOpacity(0.8))),
                          hintText: "Enter your phone number",
                          hintStyle: TextStyle(color: kPrimaryBlack),
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.phone_android,
                                color: kPrimaryBlack,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "+91    ",
                                style: TextStyle(color: kPrimaryBlack),
                              )
                            ],
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
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
                          Get.toNamed('/verifyOtp');
                        },
                        child: Text(
                          "SEND OTP",
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

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("Sign in with your phone number",
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text("Enter valid phone number, you will receive OTP."),
          // ),
          // Container(
          //   height: 60,
          //   decoration: BoxDecoration(
          //     color: kPrimaryYellow.withOpacity(0.7),
          //     borderRadius: BorderRadius.circular(10)
          //   ),
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: Row(
          //     children: [
          //       Text("+91",
          //       style: TextStyle(fontSize: 18),
          //       ),
          //       Padding(
          //        padding: EdgeInsets.symmetric(horizontal: 10),
          //         child: Container(
          //           height: 20,
          //           width: 1.5,

          //           color: Colors.black,
          //         ),
          //       ),
          //       Expanded(
          //         child: TextField(
          //           keyboardType: TextInputType.phone,
          //           cursorColor: Colors.black,
          //           decoration: InputDecoration(
          //           border: InputBorder.none,
          //           contentPadding: EdgeInsets.only(bottom:2),
          //             hintText: "Enter your phone number",
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SizedBox(
          //     width: Get.width,
          //     height: Get.height * 0.07,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: kPrimaryBlack
          //       ),
          //       onPressed: (){}, child: Text("GET OTP"),),),
          // )
        ],
      ),
    );
  }
}
