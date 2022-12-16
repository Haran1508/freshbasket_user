import 'dart:async';
import 'package:freshbasket/screens/addresses/pincode.ctrl.dart';
import 'package:freshbasket/screens/auth/auth.ctrl.dart';
import 'package:get/get.dart';

class InitialPageController extends GetxController {
  AuthController authController = Get.put(AuthController());
  PincodeController pincodeController = Get.put(PincodeController());

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (pincodeController.selectPincode != null &&
          pincodeController.selectedArea != null)
        Get.toNamed('/home');
      else
        Get.toNamed('/pincode');
    });
    super.onInit();
  }
}
