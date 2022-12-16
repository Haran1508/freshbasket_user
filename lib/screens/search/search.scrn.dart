import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:freshbasket/config/colors.dart';
import 'package:freshbasket/config/settings.dart';
import 'package:freshbasket/globals/global.dart';
import 'package:get/get.dart';
import 'search.ctrl.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroudColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Container(
          decoration: BoxDecoration(
              color: kBackgroudColor, borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.only(left: 25),
          child: TextField(
            autofocus: true,
            controller: searchController.searchTextController,
            onChanged: (value) {
              searchController.searchFunction(value);
            },
            style: TextStyle(color: kPrimaryBlack),
            cursorColor: kPrimaryBlack,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: searchText,
              hintStyle: TextStyle(color: kPrimaryBlack),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Ionicons.md_search_outline,
                  size: 22,
                  color: kPrimaryBlack,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: kPrimaryYellow,
        leading: goBackButton(),
      ),
      body: Obx(() => (searchController.result.length > 0)
          ? ListView.builder(
              itemCount: searchController.result.length,
              itemBuilder: (_, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  onTap: () {
                    // Get.toNamed('/productDetail');
                  },
                  leading: Image.network(
                      searchController.result[index].productImage!),
                  title: Text("${searchController.result[index].productName}"),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Popular Searches",
                      style: TextStyle(color: Colors.grey)),
                  Wrap(
                    spacing: 10,
                    children: searchController.popularSearches
                        .map((e) => GestureDetector(
                              onTap: () => print(e),
                              child: Chip(label: Text(e)),
                            ))
                        .toList(),
                  ),
                ],
              ),
            )),
    );
  }
}
