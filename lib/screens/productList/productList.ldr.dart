import 'package:flutter/material.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/size.dart';
import 'package:shimmer/shimmer.dart';

class ProductListLoader extends StatelessWidget {
  final BoxDecoration decoration = BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(30),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeSettings.fullWidth,
      height: sizeSettings.fullHeight,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) {
            return Container(
              width: sizeSettings.fullWidth,
              height: sizeSettings.fullHeight * 0.2,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: kBackgroudColor,
                  border: Border.all(color: Colors.grey.shade400, width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Shimmer.fromColors(
                      highlightColor: Colors.grey.shade300,
                      baseColor: Colors.grey.shade200,
                      child: Container(
                        width: sizeSettings.fullWidth / 3,
                        height: sizeSettings.fullWidth / 3,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Shimmer.fromColors(
                      highlightColor: Colors.grey.shade300,
                      baseColor: Colors.grey.shade200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: sizeSettings.fullWidth * 0.5,
                            height: 30,
                            decoration: decoration,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: sizeSettings.fullWidth * 0.2,
                                height: 30,
                                decoration: decoration,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Container(
                                  width: sizeSettings.fullWidth * 0.2,
                                  height: 30,
                                  decoration: decoration,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 30,
                                width: sizeSettings.fullWidth * 0.25,
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                decoration: decoration,
                              ),
                              Container(
                                width: sizeSettings.fullWidth * 0.2,
                                height: 30,
                                decoration: decoration,
                              ),
                              SizedBox()
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
