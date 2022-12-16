import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UserScreen extends StatelessWidget {
  AuthController authController = Get.find();

  Widget listCard(String title, bool isIcon, VoidCallback onPress,
      {IconData icon = Icons.error,
      String imageName = "",
      String subTitle = "",
      String thirdSubtitle = "",
      String secondSubTitle = "",
      bool isSubtitle = false}) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        //isThreeLine: true,
        onTap: onPress,
        leading: (isIcon)
            ? Icon(
                icon,
                color: Colors.grey.shade500,
              )
            : Image.asset(
                userIcon,
                color: Colors.grey,
                height: 20,
              ),
        title: Text(title),
        // subtitle: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text("$subTitle, $secondSubTitle"),
        //     Text("$thirdSubtitle"),
        //   ],
        // ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: kPrimaryBlack,
        ),
      ),
    );
  }

  accountBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        elevation: 5.0,
        isScrollControlled: true,
        barrierColor: kPrimaryYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: kBackgroudColor,
        context: context,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Update Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade200,
                          child: IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(
                                Icons.close,
                                color: kPrimaryBlack,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextFormField(
                        initialValue: authController.userModel!.name,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: "Name"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextFormField(
                        initialValue: authController.userModel!.email,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email Address"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextFormField(
                        initialValue: authController.userModel!.phonenumber,
                        enabled: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Phone Number"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextFormField(
                        initialValue: authController.userModel!.pincode,
                        enabled: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: "Pincode"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: TextFormField(
                        initialValue: authController.userModel!.location,
                        enabled: false,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Location"),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width * 0.98,
                      decoration: BoxDecoration(
                        color: kPrimaryBlack,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Update",
                        style: TextStyle(color: kBackgroudColor),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Account Details",
          style: TextStyle(color: kBackgroudColor),
        ),
        elevation: 0.0,
        backgroundColor: kPrimaryYellow,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios, color: kBackgroudColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: sizeSettings.fullHeight * 0.30,
              width: sizeSettings.fullWidth,
              color: kPrimaryYellow,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(),
                  Container(
                    child: Image.asset(
                      userIcon,
                      color: kPrimaryBlack.withOpacity(0.8),
                    ),
                    padding: EdgeInsets.all(25),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      authController.userModel!.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kBackgroudColor),
                    ),
                  ),
                  Text(
                    authController.userModel!.phonenumber,
                    style: TextStyle(
                        fontSize: 16, color: kBackgroudColor.withOpacity(0.5)),
                  ),
                  Spacer()
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                listCard(
                    "Profile Details", false, () => accountBottomSheet(context),
                    imageName: userIcon,
                    subTitle: "Anand Kumar",
                    secondSubTitle: "8778619412",
                    thirdSubtitle: "test@gmail.com"),
                listCard(
                  "My Addresses",
                  true,
                  () => Get.toNamed('/existingAddress'),
                  icon: Ionicons.location_outline,
                  subTitle: "No Address",
                ),
                listCard(
                  "My Orders",
                  true,
                  () {},
                  icon: Ionicons.cart_outline,
                ),
                listCard("Privacy Policy", true, () {},
                    icon: MaterialIcons.privacy_tip),
                listCard("Terms & Conditions", true, () {},
                    icon: MaterialCommunityIcons.watermark),
                listCard("LogOut", true, () {}, icon: AntDesign.logout),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
