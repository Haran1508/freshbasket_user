import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:freshbasket/screens/wallet/wallet.ctrl.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class WalletScreen extends StatelessWidget {
 WalletController walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        SizedBox(
          width: sizeSettings.fullWidth,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: kPrimaryBlack),
            onPressed: () {
              walletController.addWalletAmount();
              // Get.defaultDialog(
              //   title: "Error",
              //   content: Text("Please Enter valid Amount"),
              //   confirm: TextButton(
              //       style: TextButton.styleFrom(
              //         primary: kPrimaryBlack,
              //         backgroundColor: kPrimaryYellow
              //       ),
              //       child: Text("Ok"),
              //       onPressed: ()=> Get.back(),
              //     )
              // );
              // showDialog(context: context, builder: (BuildContext context)=> 
              // CupertinoAlertDialog(
              //   title: Text("Alert"),
              //   content: Text("Please Enter Amount"),
              //   actions: [
              //     TextButton(
              //       child: Text("Ok"),
              //       onPressed: ()=> Get.back(),
              //     )
              //   ],
              // )
              //);
              
            },
            child: Text(
              "Add Amount",
              style: TextStyle(fontSize: 18, color: kBackgroudColor),
            ),
          ),
        )
      ],
      appBar: AppBar(
          centerTitle: true,
          title: Text("My Wallet", 
          style: TextStyle(color: kPrimaryBlack)
          ),
          elevation: 0.0,
          backgroundColor: kPrimaryYellow,
          leading: goBackButton()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: sizeSettings.fullHeight * 0.20,
                width: sizeSettings.fullWidth,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                color: kPrimaryYellow.withOpacity(0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wallet Balance",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹ 30.00",
                      style: GoogleFonts.roboto(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "View All Transactions".toUpperCase(),
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: kPrimaryRed),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add Amount",
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "We suggest you to add average balance of ₹500",
                style: TextStyle(color: Colors.grey.shade500),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black38)),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Builder(builder: (context) {
                    return Text("₹  ",
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                        ));
                  }),
                  TextField(
                    controller: walletController.amountController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixText: '₹  ',
                      prefixStyle: TextStyle(color: Colors.transparent),
                    ),
                  )
                ],
              ),
            ),
            Text("Add Quick Amount"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.2),
                  ),
                  onPressed: () => walletController
                      .onDefaultAmount(walletController.amountList[0]),
                  child: Text(
                    "₹ 500",
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: kPrimaryBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.2),
                  ),
                  onPressed: () => walletController
                      .onDefaultAmount(walletController.amountList[1]),
                  child: Text(
                    "₹ 1,000",
                    style: GoogleFonts.roboto(
                        color: kPrimaryBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.withOpacity(0.2),
                  ),
                  onPressed: () => walletController
                      .onDefaultAmount(walletController.amountList[2]),
                  child: Text(
                    "₹ 2,000",
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: kPrimaryBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Notification Email Address",
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: walletController.emailController,
                decoration: InputDecoration(
                    hintText: "test@gmail.com", border: OutlineInputBorder()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
