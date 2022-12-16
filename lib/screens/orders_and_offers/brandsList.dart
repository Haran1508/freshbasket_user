import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:freshbasket/models/brandModel.dart';
import 'package:freshbasket/screens/brands/brandlist.ctrl.dart';
import 'package:freshbasket/screens/home/home.ctrl.dart';
import 'package:get/get.dart';

class BrandsList extends StatefulWidget {
  const BrandsList({Key? key}) : super(key: key);

  @override
  _BrandsListState createState() => _BrandsListState();
}

class _BrandsListState extends State<BrandsList> {
  // AddressController addressController = Get.put(AddressController());
  HomeController homeController = Get.put(HomeController());
  BrandController brandController = Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double fontSize = (size.width) / 100;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryYellow,
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          "Brands List",
          style: TextStyle(color: kBackgroudColor),
        ),
        leading: goBackButton(),
      ),
      body: /*onOrdersWidget(fontSize)*/ brandListView(),
    );
  }

  Widget brandListView() {
    return SingleChildScrollView(
      child: Obx(
        () => Container(
          width: Get.width,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: Get.width * 0.10,
            spacing: Get.width * 0.08,
            children: homeController.brands
                .map((e) => brandCard(e, homeController.brands.indexOf(e)))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget brandCard(BrandModel brandModel, int colorId) {
    return InkWell(
      onTap: () {
        homeController.fetchBrandProducts(brandModel.brandId);
        brandController.selectBrand(brandModel);
        Get.toNamed('/brandproductsList');
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Get.width * 0.25,
            width: Get.width * 0.25,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(2, 2))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(brandModel.image),
          ),
          Container(
            width: Get.width * 0.22,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 5),
            child: Text(
              brandModel.brandName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Center onOrdersWidget(double fontSize) {
    return Center(
      child: Text(
        "No brands found!",
        style: TextStyle(
          color: Colors.grey,
          fontSize: fontSize * 5.5,
        ),
      ),
    );
  }
}
