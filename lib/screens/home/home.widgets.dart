import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/config/size.dart';

class HomeWidgets {
  Widget addAmountButton(String name, VoidCallback onPress) {
    return Padding(
      padding: EdgeInsets.all(sizeSettings.blockWidth * 3),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10),
            side: BorderSide(color: kPrimaryBlack, width: 0.5),
            primary: kPrimaryBlack,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: onPress,
          child: Row(
            children: [
              Icon(
                Icons.add_circle,
                size: sizeSettings.iconSize,
              ),
              Text(
                name,
                style: textSettings.addMoneyStyle,
              )
            ],
          )),
    );
  }

  Widget searchBox({required Function onPress}) {
    return Container(
      height: sizeSettings.blockWidth * 13,
      width: sizeSettings.fullWidth,
      color: kPrimaryYellow,
      padding: EdgeInsets.symmetric(
          horizontal: sizeSettings.fullWidth * 0.03, vertical: 8),
      child: Container(
        height: 35,
        width: sizeSettings.fullWidth,
        decoration: BoxDecoration(
            color: kBackgroudColor, borderRadius: BorderRadius.circular(30)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onPress(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(searchText),
                  Spacer(),
                  Icon(
                    Ionicons.md_search_outline,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
