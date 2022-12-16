import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/config/size.dart';
import 'package:freshbasket/utils/snackbarWidget.dart';
import 'package:get/get.dart';
import 'pincode.ctrl.dart';

class PincodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PincodeSelection(),
    );
  }
}

// ignore: must_be_immutable
class PincodeSelection extends StatefulWidget {
  @override
  _PincodeSelectionState createState() => _PincodeSelectionState();
}

class _PincodeSelectionState extends State<PincodeSelection> {
  PincodeController _pincodeController = Get.put(PincodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroudColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: Get.height * 0.05)),
            Container(
              height: sizeSettings.fullWidth * 0.20,
              width: sizeSettings.fullWidth * 0.20,
              decoration: BoxDecoration(
                  color: kPrimaryYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100)),
              child: Image.asset(
                appLogo,
                height: sizeSettings.blockWidth * 15,
                width: sizeSettings.blockWidth * 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "User Location",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: (Get.width / 100) * 5),
              ),
            ),
            Text(
              "Please enter your pincode properly for better products listing available on your location",
              style: TextStyle(fontSize: (Get.width / 100) * 3),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: (Get.width / 100) * 3),
            Container(
              height: 60,
              width: Get.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _pincodeController.pincodeController,
                      onChanged: (value) {
                        if (value.length > 4)
                          _pincodeController.verifyPincode();
                      },
                      keyboardType: TextInputType.phone,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 2),
                        hintText: "Enter your area pincode",
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: kPrimaryYellow,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () async {
                        if (!_pincodeController.pincodeController.value.text
                            .contains('/'))
                          errorSnackBar(
                              "Error", "Choose Correct Location from List");
                        else {
                          await _pincodeController.getPincodeAndArea();
                          if (_pincodeController.selectPincode != null &&
                              _pincodeController.selectedArea != null)
                            Get.toNamed('/home');
                        }
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Get.height * 0.47,
              child: Obx(
                () => ListView.builder(
                  itemCount: _pincodeController.pincodeList.length,
                  itemBuilder: (_, index) => ListTile(
                    onTap: () {
                      _pincodeController.pincodeController.text =
                          _pincodeController.pincodeList[index].area +
                              "/" +
                              _pincodeController.pincodeList[index].pincode
                                  .toString();
                      _pincodeController.setPincodeAndArea(
                          _pincodeController.pincodeList[index].area,
                          _pincodeController.pincodeList[index].pincode);
                    },
                    title: Text(_pincodeController.pincodeList[index].area),
                    subtitle: Text(
                      _pincodeController.pincodeList[index].pincode.toString(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: (Get.width / 100) * 3.5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryYellow),
                  onPressed: () {
                    _pincodeController.getDevicePincode();
                  },
                  child: Text("My Current Location"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
