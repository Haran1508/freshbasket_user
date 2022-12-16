import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/size.dart';
import 'package:get/get.dart';

Widget goBackButton() {
  return IconButton(
    icon: Icon(Icons.arrow_back_ios, color: kBackgroudColor),
    onPressed: () => Get.back(),
    iconSize: sizeSettings.blockWidth * 5,
  );
}
