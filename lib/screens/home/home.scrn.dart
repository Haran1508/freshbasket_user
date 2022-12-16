// ignore: import_of_legacy_library_into_null_safe
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:freshbasket/utils/loaderWidget.dart';
import 'package:get/get.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/models/brandModel.dart';
import 'package:freshbasket/models/categoryModel.dart';
import 'package:freshbasket/screens/addresses/pincode.ctrl.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:freshbasket/screens/brands/brandlist.ctrl.dart';
import 'package:freshbasket/screens/cart/cart.ctrl.dart';
import 'package:freshbasket/screens/home/home.ctrl.dart';
import 'package:freshbasket/screens/home/home.widgets.dart';
import 'package:freshbasket/screens/wallet/wallet.ctrl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  AuthController authController = Get.put(AuthController());
  WalletController walletController = Get.put(WalletController());
  BrandController brandController = Get.put(BrandController());
  PincodeController pincodeController = Get.find();
  CartController cartController = Get.put(CartController());
  HomeWidgets homeWidgets = HomeWidgets();

  Widget titleText({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget categoryListView() {
    return Obx(
      () => Container(
        width: Get.width,
        height: Get.width * 0.41 * (homeController.categories.length / 3),
        alignment: Alignment.center,
        child: Wrap(
          runSpacing: 16,
          spacing: 12,
          children: homeController.categories
              .map((e) => categoryCard(e, homeController.categories.indexOf(e)))
              .toList(),
        ),
      ),
    );
  }

  Widget brandListView() {
    return Obx(
      () => Container(
        width: Get.width,
        padding: EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        child: Wrap(
          runSpacing: Get.width * 0.01,
          spacing: Get.width * 0.03,
          children: homeController.brands
              .map((e) => brandCard(e, homeController.brands.indexOf(e)))
              .toList(),
        ),
      ),
    );
  }

  Widget topRow(
      {required BuildContext context,
      required List<CategoriesModel> categoriesList}) {
    return Container(
      height: 123,
      width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoriesList.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 15, right: 15),
                  child: Material(
                    color: Colors.white,
                    // elevation: 3,
                    shadowColor: Colors.grey.shade500,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: InkWell(
                      onTap: () {
                        homeController
                            .fetchCategoryProducts(categoriesList[index].catId);
                        brandController.selectCategory(categoriesList[index]);
                        Get.toNamed('/productList');
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 65,
                        width: 65,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white.withOpacity(0.5),
                            border: Border.all(
                                color: kPrimaryYellow.withOpacity(0.1),
                                width: 4)),
                        child: Image.network(categoriesList[index].image),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 75,
                  child: Text(
                    categoriesList[index].catName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget categoryCard(CategoriesModel categoriesModel, int colorId) {
    return InkWell(
      onTap: () {
        /* homeController.fetchCategoryProducts(categoriesModel.catId);
        brandController.selectCategory(categoriesModel);
        Get.toNamed('/productList');*/
        homeController.fetchCategoryProducts(categoriesModel.catId);
        brandController.selectCategory(categoriesModel);
        Get.toNamed('/gridProductList');
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Get.width * 0.30,
            width: Get.width * 0.30,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: bgColorList[5], borderRadius: BorderRadius.circular(8)),
            child: Image.network(categoriesModel.image),
          ),
          Container(
            width: Get.width * 0.30,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 5),
            child: Text(
              categoriesModel.catName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          )
        ],
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
            height: Get.width * 0.16,
            width: Get.width * 0.22,
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

  openDrawer(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => homeController.scaffoldKey.currentState?.openDrawer(),
      icon: Image.asset(
        menuIcon,
        color: kBackgroudColor,
        height: 16,
      ),
    );
  }

  Widget sideNavBar() {
    return Drawer(
      child: Container(
        height: sizeSettings.fullHeight,
        width: sizeSettings.fullWidth * 0.06,
        color: kBackgroudColor,
        child: Column(
          children: [
            Material(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Obx(
                    () => ListTile(
                      onTap: () {
                        Get.back();
                        Get.toNamed('/user');
                      },
                      leading: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(
                          userIcon,
                          height: (sizeSettings.iconSize +
                              sizeSettings.blockWidth * 2),
                          color: kPrimaryBlack,
                        ),
                      ),
                      title: (authController.userSignedIn.value &&
                              authController.userModel != null)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                authController.userModel!.name,
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryYellow),
                                  onPressed: () {
                                    Get.back();
                                    Get.toNamed('/userlogin');
                                  },
                                  child: Text("Login"),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryYellow),
                                  onPressed: () {
                                    Get.back();
                                    Get.toNamed('/phoneAuth');
                                  },
                                  child: Text("Register"),
                                ),
                              ],
                            ),
                      subtitle: (authController.userSignedIn.value)
                          ? Text(authController.userModel!.phonenumber)
                          : Container(),
                      isThreeLine: true,
                      trailing: ((authController.userSignedIn.value)
                          ? Icon(Icons.arrow_forward_ios)
                          : null),
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey.shade300,
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/categoriesList');
                    },
                    leading: Icon(Feather.database),
                    title: Text("All Categories"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/brandsList');
                    },
                    leading: Icon(Feather.trello),
                    title: Text("All Brands"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/branches');
                    },
                    leading: Icon(MaterialIcons.business),
                    title: Text("Our Branches"),
                  ),
                  /* ListTile(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/offers');
                    },
                    leading: Icon(Feather.gift),
                    title: Text("Offers"),
                  ),*/
                  ListTile(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/ordersList');
                    },
                    leading: Icon(AntDesign.shoppingcart),
                    title: Text("My Orders"),
                  ),
                  ListTile(
                    onTap: () async {
                      Get.back();
                      await launch("tel: 9898989898");
                    },
                    leading: Icon(MaterialIcons.call),
                    title: Text("Contact Us"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.back();
                      Get.toNamed('/feedback');
                    },
                    leading: Icon(MaterialIcons.support_agent),
                    title: Text("FeedBack"),
                  ),
                  Obx(
                    () => (authController.userSignedIn.value)
                        ? ListTile(
                            onTap: () {
                              authController.logoutUser();
                            },
                            leading: Icon(MaterialIcons.logout),
                            title: Text("Logout"),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            Spacer(),
            Divider(thickness: 2),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text("version: 0.1"),
            )
          ],
        ),
      ),
    );
  }

  buildCarousel({required BuildContext context}) {
    return Obx(
      () => (homeController.bannerList.length > 0)
          ? Carousel(
              showIndicator: true,
              dotBgColor: Colors.transparent,
              dotColor: Colors.black,
              dotIncreasedColor: Colors.white,
              overlayShadow: true,
              autoplay: true,
              animationDuration: Duration(seconds: 3),
              autoplayDuration: Duration(seconds: 4),
              indicatorBgPadding: 10,
              boxFit: BoxFit.cover,
              onImageTap: (index) {
                // BannerModel banners =
                //     homeController.homeScreenModel.value.banners[index];
                // Get.to(
                //   ProductsListScreen(
                //       category: banners.catName, catId: banners.catId),
                // );
              },
              images: homeController.bannerList.map((e) {
                return Image.network(e.image,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Shimmer.fromColors(
                    child: Container(
                      color: Colors.green,
                      alignment: Alignment.center,
                      child: Text("Loading"),
                    ),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                  );
                }, fit: BoxFit.cover);
              }).toList())
          : Shimmer.fromColors(
              child: Container(
                color: Colors.green,
                alignment: Alignment.center,
                child: Text("Loading"),
              ),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
            ),
    );
  }

  Widget contactUsWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: 2),
          titleText(title: "Contact Us (Main Office)"),
          contactSubWidget(Icons.pin_drop_rounded, "Main Address Goes Here"),
          contactSubWidget(Icons.mail, "testmail@gmail.com"),
          contactSubWidget(Icons.phone_android, "88888 88888"),
          Divider(thickness: 2),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(title: "More Information"),
                    moreInfoItems("About Us", () {}),
                    moreInfoItems("Delivery Information", () {}),
                    moreInfoItems("Privacy Policy", () {}),
                    moreInfoItems("Terms and Conditions", () {}),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(title: "Customer Service"),
                    moreInfoItems("Contact Us", () {}),
                    moreInfoItems("Feedback", () {}),
                    moreInfoItems("Track Order", () {}),
                    moreInfoItems("", () => false, false),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 2),
          Center(child: titleText(title: "Follow Us on:")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(child: ClipOval(child: Image.asset(fbIcon))),
                SizedBox(width: 10),
                InkWell(child: ClipOval(child: Image.asset(ytIcon))),
                SizedBox(width: 10),
                InkWell(child: ClipOval(child: Image.asset(twIcon))),
                SizedBox(width: 10),
                InkWell(child: ClipOval(child: Image.asset(inIcon))),
              ],
            ),
          ),
          Divider(thickness: 2),
          allRightsReservedWidget(),
        ],
      ),
    );
  }

  GestureDetector moreInfoItems(String text, VoidCallback onTap,
      [bool isIcon = true]) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Row(
          children: [
            if (isIcon)
              Icon(
                Icons.circle,
                size: 7,
              ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }

  Container allRightsReservedWidget() {
    return Container(
      color: Colors.black87,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("2022 All Rights Reserved  ",
              style: TextStyle(color: Colors.white)),
          Text("Namma FreshBasket", style: TextStyle(color: kPrimaryGreen))
        ],
      ),
    );
  }

  Padding contactSubWidget(IconData iconName, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.circular(5)),
            child: Icon(
              iconName,
              color: Colors.black54,
              size: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.homeLoading.value)
        return Scaffold(
            body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: sizeSettings.fullWidth * 0.8,
                    height: sizeSettings.fullHeight * 0.3,
                    child: Image.asset("assets/bg1.png", fit: BoxFit.cover),
                  ),
                  Text("Nama FreshBasket",
                      style: GoogleFonts.carterOne(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryYellow,
                        fontSize: sizeSettings.blockWidth * 6,
                      )),
                  Text(
                    "Your one stop destiny for all Groceries",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: sizeSettings.blockWidth * 2.5,
                        color: kPrimaryYellow,
                        letterSpacing: 1.2),
                  ),
                ],
              ),
            ),
            LoaderWidget()
          ],
        ));
      else
        return Scaffold(
          key: homeController.scaffoldKey,
          appBar: AppBar(
            elevation: 0.0,
            leading: openDrawer(context),
            backwardsCompatibility: false,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: kPrimaryYellow),
            backgroundColor: kPrimaryYellow,
            brightness: Brightness.dark,
            title: InkWell(
              onTap: () => Get.toNamed('/pincode'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appName,
                    style: textSettings.titleTextStyle
                        .copyWith(color: kBackgroudColor),
                  ),
                  Text(
                      pincodeController.selectedArea! +
                          "-" +
                          pincodeController.selectPincode.toString(),
                      style: TextStyle(color: kBackgroudColor, fontSize: 12)),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => Get.toNamed('/notification'),
                icon: Obx(
                  () => Stack(
                    children: [
                      Icon(Icons.notifications, color: Colors.white),
                      if (cartController.productsCodeList.length > 0)
                        Positioned(
                          child: Container(
                            height: 15,
                            width: 15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              cartController.productsCodeList.length.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              IconButton(
                onPressed: () => Get.toNamed('/cart'),
                icon: Obx(
                  () => Stack(
                    children: [
                      Icon(Icons.shopping_bag, color: Colors.white),
                      if (cartController.productsCodeList.length > 0)
                        Positioned(
                          child: Container(
                            height: 15,
                            width: 15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              cartController.productsCodeList.length.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
              //homeWidgets.addAmountButton(addpay,
              //() => Get.toNamed('/wallet')),
            ],
          ),
          drawer: sideNavBar(),
          body: WillPopScope(
            onWillPop: () => exit(0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    homeWidgets.searchBox(
                        onPress: () => homeController.searchClick),
                    Obx(
                      () => topRow(
                          context: context,
                          categoriesList: homeController.categories),
                    ),
                    titleText(title: "Featured"),
                    Container(
                        height: sizeSettings.fullHeight * 0.32,
                        width: sizeSettings.fullWidth,
                        child: buildCarousel(context: context)),
                    titleText(title: "Shop By Brands"),
                    brandListView(),
                    titleText(title: "Shop By Categories"),
                    categoryListView(),
                    contactUsWidget()
                  ]),
            ),
          ),
        );
    });
  }
}
