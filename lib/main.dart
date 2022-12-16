import 'package:freshbasket/screens/addresses/existingAddress.dart';
import 'package:freshbasket/screens/brands/brandlist.scrn.dart';
import 'package:freshbasket/screens/orders_and_offers/brandsList.dart';
import 'package:freshbasket/screens/orders_and_offers/categoriesList.dart';
import 'package:freshbasket/screens/productList/productList.grid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/settings.dart';
import 'package:get/get.dart';
import 'screens/addresses/addAddress.dart';
import 'screens/addresses/pincode.screen.dart';
import 'screens/auth/phoneAuth.scrn.dart';
import 'screens/auth/status.scrn.dart';
import 'screens/auth/userRegistration.scrn.dart';
import 'screens/auth/userlogin.scrn.dart';
import 'screens/auth/verifyOtp.scrn.dart';
import 'screens/branches/ourbranches.scrn.dart';
import 'screens/cart/cart.scrn.dart';
import 'screens/cart/deliveryOption.dart';
import 'screens/cart/orderTrack.dart';
import 'screens/cart/thankyou.dart';
import 'screens/home/feedback.screen.dart';
import 'screens/home/home.scrn.dart';
import 'screens/initial/initialpage.scrn.dart';
import 'screens/notification/notificationsScreen.dart';
import 'screens/orders_and_offers/offers.screen.dart';
import 'screens/orders_and_offers/ordersList.dart';
import 'screens/productList/productsList.scrn.dart';
import 'screens/search/search.scrn.dart';
import 'screens/user/user.scrn.dart';
import 'screens/wallet/wallet.scrn.dart';
import 'dart:io' as io;

/* 
https://www.behance.net/gallery/89205249/Grocery-Shopping-App-UI-Kit
https://www.behance.net/gallery/95130103/Grocery-Shopping-App-Android
*/

class MyHttpoverrides extends io.HttpOverrides {
  @override
  io.HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (io.X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = new MyHttpoverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(InitialApp()),
  );
}

class InitialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //precacheImage(AssetImage(appBackground), context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.white),
      child: GetMaterialApp(
        title: appName,
        enableLog: false,
        defaultTransition: Transition.rightToLeft,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //textTheme: GoogleFonts.robotoTextTheme()
            appBarTheme:
                AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
            textTheme: GoogleFonts.poppinsTextTheme()),
        initialRoute: '/',
        getPages: [
          GetPage(
              name: '/',
              page: () => InitialPage(),
              transition: Transition.zoom),
          GetPage(
              name: '/home',
              page: () => HomeScreen(),
              transition: Transition.rightToLeft),
          GetPage(name: '/search', page: () => SearchScreen()),
          GetPage(
              name: '/brandproductsList', page: () => BrandProductListScreen()),
          GetPage(name: '/user', page: () => UserScreen()),
          GetPage(name: '/phoneAuth', page: () => PhoneAuthScreen()),
          GetPage(name: '/userlogin', page: () => UserLoginScreen()),
          GetPage(name: '/verifyOtp', page: () => VerifyOtpScreen()),
          GetPage(name: '/cart', page: () => CartScreen()),
          GetPage(name: '/wallet', page: () => WalletScreen()),
          GetPage(name: '/branches', page: () => OurBranchesScreen()),
          GetPage(name: '/pincode', page: () => PincodeScreen()),
          GetPage(name: '/successAlert', page: () => StatusScreen()),
          GetPage(name: '/checkout', page: () => DeliveryOptionScreen()),
          GetPage(name: '/addNewAddress', page: () => AddAddress()),
          GetPage(name: '/feedback', page: () => FeedBackForm()),
          GetPage(name: '/existingAddress', page: () => ExistingAddress()),
          GetPage(name: '/ordersList', page: () => OrdersList()),
          GetPage(name: '/offers', page: () => OffersList()),
          GetPage(name: '/categoriesList', page: () => CategoriesList()),
          GetPage(name: '/brandsList', page: () => BrandsList()),
          GetPage(name: '/thankyou', page: () => ThankYouScreen()),
          GetPage(name: '/trackorder', page: () => TrackOrder()),
          GetPage(name: '/registerUser', page: () => RegisterUserScreen()),
          GetPage(name: '/notification', page: () => NotificationScreen()),
          GetPage(name: '/gridProductList', page: () => GridProductList()),
          GetPage(
              name: '/productList',
              page: () => CategoryWiseProductListScreen()),
        ],
      ),
    );
  }
}
