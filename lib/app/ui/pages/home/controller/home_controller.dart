import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/pages/category/model/category_model.dart';
import 'package:market_nest_app/app/ui/pages/home/repository/home_repository.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';

class HomeController extends GetxController{
  final HomeRepository repository;

  HomeController({required this.repository});

  var categories = <CategoryModel>[].obs;
  var products = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchedProductByLength(2.toString());
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      categories.value = await repository.fetchCategories();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    } finally {
      isLoading(false);
    }
  }

  void fetchedProductByLength(String limit) async {
    try {
      isLoading(true);
      products.value = await repository.fetchedProductByLength(limitItem: limit);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load sub-categories');
    } finally {
      isLoading(false);
    }
  }
}