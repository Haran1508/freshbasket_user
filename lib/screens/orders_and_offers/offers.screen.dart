import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/globals/global.dart';

class OffersList extends StatefulWidget {
  const OffersList({Key? key}) : super(key: key);

  @override
  _OffersListState createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  // AddressController addressController = Get.put(AddressController());

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
          "Offers",
          style: TextStyle(color: kBackgroudColor),
        ),
        leading: goBackButton(),
      ),
      body: onOffersWidget(fontSize),
    );
  }

  Center onOffersWidget(double fontSize) {
    return Center(
      child: Text(
        "Currently No offers found!",
        style: TextStyle(
          color: Colors.grey,
          fontSize: fontSize * 5.5,
        ),
      ),
    );
  }
}
