import 'package:flutter/cupertino.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:get/get.dart';

class SizeSettings {
  final double fullWidth = Get.width;
  final double fullHeight = Get.height;
  final double blockHeight = (Get.height / 100);
  final double blockWidth = (Get.width / 100);
  final double fontSize = (Get.width / 100);
  final double iconSize = (Get.width / 100) * 4.2;
}

SizeSettings sizeSettings = SizeSettings();

class TextSettings {
  TextStyle titleTextStyle = TextStyle(
      fontSize: sizeSettings.blockWidth * 4,
      fontWeight: FontWeight.bold,
      color: kPrimaryBlack);

  TextStyle addMoneyStyle = TextStyle(
      fontWeight: FontWeight.w100, fontSize: sizeSettings.blockWidth * 3);
}

TextSettings textSettings = TextSettings();
