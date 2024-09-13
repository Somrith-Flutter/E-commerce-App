import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/global_widgets/text_widget.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';
import 'package:market_nest_app/app/ui/pages/my_card_page/controller/my_cart_controller.dart';
import 'package:gap/gap.dart';
import 'package:market_nest_app/common/constants/api_path.dart';

class MyCardScreen extends StatelessWidget {
  const MyCardScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    MyCartController cartController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cartController.cartItems.isEmpty) {
          return _buildEmptyCartView();
        } else {
          return _buildCartListView(cartController);
        }
      }),
    );
  }

  Widget _buildEmptyCartView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_cart.png',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 32),
            const TextWidget(
              'Your cart is empty',
              size: 22,
              bold: true,
            ),
            const Gap(16),
            const TextWidget(
              'Looks like you have not added anything in your cart. '
              'Go ahead and explore top categories.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to categories or product listing
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryBlack,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const TextWidget(
                  'Explore Categories',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartListView(MyCartController cartController) {
    return ListView.builder(
      itemCount: cartController.cartItems.length,
      itemBuilder: (context, index) {
        ProductModel product = cartController.cartItems[index];
        return _buildCartItem(product);
      },
    );
  }

  Widget _buildCartItem(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        children: [
          // Product Image
          Image.network(
            ApiPath.baseUrl() + product.imageUrl.first,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image, size: 80);
            },
          ),
          const Gap(16),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  product.productName,
                  size: 16,
                  bold: true,
                ),
                const Gap(4),
                TextWidget(
                  '\$${product.prices.toStringAsFixed(2)}',
                  size: 16,
                  color: Colors.green,
                ),
              ],
            ),
          ),

          // Remove or adjust quantity (optional)
          IconButton(
            onPressed: () {
              // Logic to remove the product from the cart
            },
            icon: const Icon(Icons.remove_circle_outline),
          ),
        ],
      ),
    );
  }
}
