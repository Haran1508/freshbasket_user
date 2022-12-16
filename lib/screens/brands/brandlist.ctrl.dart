import 'package:freshbasket/models/brandModel.dart';
import 'package:freshbasket/models/categoryModel.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  late BrandModel selectedBrand;
  late CategoriesModel selectedCategory;

  selectBrand(BrandModel brandModel) {
    selectedBrand = brandModel;
  }

  selectCategory(CategoriesModel categoriesModel) =>
      selectedCategory = categoriesModel;
}
