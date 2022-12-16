import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:get/get.dart';

import 'address.ctrl.dart';

class ExistingAddress extends StatefulWidget {
  const ExistingAddress({Key? key}) : super(key: key);

  @override
  _ExistingAddressState createState() => _ExistingAddressState();
}

class _ExistingAddressState extends State<ExistingAddress> {
  AddressController addressController = Get.put(AddressController());

  @override
  void initState() {
    addressController.searchExistAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryYellow,
        centerTitle: true,
        title: Text(
          "Previous Delivery Address",
          style: TextStyle(color: kBackgroudColor),
        ),
        leading: goBackButton(),
      ),
      body: Obx(
        () => (addressController.loading.value)
            ? Container()
            : ListView.builder(
                itemCount: addressController.addressList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      onTap: () {
                        addressController.setExistingAddress(
                            addressController.addressList[index]);
                        Get.back();
                      },
                      leading: Icon(Icons.location_city),
                      title: Text(addressController.addressList[index]),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
