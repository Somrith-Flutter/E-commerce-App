import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/ui/pages/product/controller/product_controller.dart';
import 'package:market_nest_app/app/ui/pages/product/repository/product_repository.dart';

class ProductScreen extends StatelessWidget {
  final int subCategoryId;

  ProductScreen({required this.subCategoryId, super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(
      ProductController(repository: ProductRepository()),
    );

    productController.fetchProducts(subCategoryId: subCategoryId);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (productController.products.isEmpty) {
          return const Center(child: Text('No products available.'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: productController.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2 / 2,
              ),
              itemBuilder: (context, index) {
                final product = productController.products[index];
                return InkWell(
                  onTap: () {
                    // Handle product click, e.g., navigate to product detail page
                  },
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.blue[50],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            ApiPath.baseUrl + product.imageUrl,
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 40);
                            },
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            product.productName,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
