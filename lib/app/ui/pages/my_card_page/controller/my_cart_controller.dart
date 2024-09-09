import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';
import 'package:market_nest_app/app/ui/pages/my_card_page/repository/my_cart_repository.dart';

class MyCartController extends GetxController {
  MyCartController({required this.repository});

  final MyCartRepository repository;

  // Cart items
  var cartItems = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      isLoading(true);
      final fetchedItems = await repository.fetchCartList();
      cartItems.assignAll(fetchedItems);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch cart items");
    } finally {
      isLoading(false);
    }
  }
}
