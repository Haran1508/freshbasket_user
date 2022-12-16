import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/config/size.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroudColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              successBg,
              height: sizeSettings.blockWidth * 35,
              width: sizeSettings.blockWidth * 35,
            ),
            Text(
              "Great! Phone Number verified.",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
