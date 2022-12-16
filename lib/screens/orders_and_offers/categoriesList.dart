import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:freshbasket/models/categoryModel.dart';
import 'package:freshbasket/screens/brands/brandlist.ctrl.dart';
import 'package:freshbasket/screens/home/home.ctrl.dart';
import 'package:get/get.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
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
          "Categories",
          style: TextStyle(color: kBackgroudColor),
        ),
        leading: goBackButton(),
      ),
      body: /*oncatgorysWidget(fontSize)*/ Obx(
        () =>
            topRow(context: context, categoriesList: homeController.categories),
      ),
    );
  }

  Center oncatgorysWidget(double fontSize) {
    return Center(
      child: Text(
        "No Categories found!",
        style: TextStyle(
          color: Colors.grey,
          fontSize: fontSize * 5.5,
        ),
      ),
    );
  }

  Widget topRow(
      {required BuildContext context,
      required List<CategoriesModel> categoriesList}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              homeController.fetchCategoryProducts(categoriesList[index].catId);
              brandController.selectCategory(categoriesList[index]);
              Get.toNamed('/productList');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Get.width * 0.30,
                  width: Get.width * 0.30,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: bgColorList[5],
                      borderRadius: BorderRadius.circular(8)),
                  child: Image.network(categoriesList[index].image),
                ),
                Container(
                  width: Get.width * 0.30,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    categoriesList[index].catName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height /1.5),
        ),
      ),
    );
  }
}
