import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/pages/home/repository/home_repository.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';
import 'package:market_nest_app/app/ui/pages/product/repository/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository repository;

  ProductController({required this.repository});

  var products = <ProductModel>[].obs;
  var isLoading = true.obs;


  void fetchProducts({required int subCategoryId}) async {
    try {
      isLoading(true);
      products.value =
          await repository.fetchProducts(subCategoryId: subCategoryId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchedProductByLength(String limit) async {
    try {
      isLoading(true);
      var result = await HomeRepository().fetchedProductByLength(limitItem: limit);
      products.value = result;
        } catch (e) {
      Get.snackbar('Error', 'Failed to load sub-categories');
    } finally {
      isLoading(false);
    }
  }
}
