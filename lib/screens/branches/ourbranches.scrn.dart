import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/models/branchModel.dart';
import 'package:freshbasket/screens/home/home.ctrl.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OurBranchesScreen extends StatelessWidget {
  HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: kPrimaryYellow),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryYellow,
            centerTitle: true,
            title: Text("Our Branches"),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         // _homeController.getToken();
            //       },
            //       icon: Icon(Icons.cabin))
            // ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Wrap(
                runAlignment: WrapAlignment.spaceAround,
                spacing: 5,
                children: [
                  for (int i = 0; i < _homeController.branches.length; i++) ...{
                    BranchWidget(
                      branches: _homeController.branches[i],
                    ),
                  }
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BranchWidget extends StatelessWidget {
  final Branches branches;
  BranchWidget({
    required this.branches,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 150,
        child: Card(
          elevation: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: sizeSettings.fullWidth * 0.45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: kPrimaryYellow.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    )),
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: Text(
                  branches.branchName,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryYellow),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: Get.width / 2.5,
                  child: Text(
                    branches.address + "," + branches.pincode,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Phone: ${branches.phoneNumber}"),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text("Land:${branches.landLine}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
