import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/ui/pages/category/controller/category_controller.dart';
import 'package:market_nest_app/app/ui/pages/category/repository/category_repository.dart';
import 'package:market_nest_app/app/ui/pages/category/model/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  // Ensure controller is initialized with Get.put()
  final CategoryController categoryController =
      Get.put(CategoryController(repository: CategoryRepository()));

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categories",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (categoryController.categories.isEmpty) {
          return const Center(child: Text('No categories available.'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: categoryController.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2 / 2,
              ),
              itemBuilder: (context, index) {
                CategoryModel category = categoryController.categories[index];                
                return InkWell(
                  onTap: () {
                    print('Tapped on ${category.name}');
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
                            ApiPath.baseUrl + category.imageUrl,
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // Handle image loading error
                              return const Icon(Icons.broken_image, size: 40);
                            },
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            category.description,
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
