import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/controller/sub_category_controller.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/repository/sub_category_repository.dart';

class SubCategoriesScreen extends StatelessWidget {
  final int categoryId;

  SubCategoriesScreen({required this.categoryId, super.key});

  @override
  Widget build(BuildContext context) {
    final SubCategoryController subCategoryController = Get.put(
      SubCategoryController(repository: SubCategoryRepository()),
    );

    subCategoryController.fetchSubCategories(categoryId: categoryId);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sub-Categories",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        if (subCategoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (subCategoryController.subCategories.isEmpty) {
          return const Center(child: Text('No sub-categories available.'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: subCategoryController.subCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2 / 2,
              ),
              itemBuilder: (context, index) {
                final subCategory = subCategoryController.subCategories[index];
                return InkWell(
                  onTap: () {
                    // Handle sub-category click
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
                            ApiPath.baseUrl + subCategory.imageUrl,
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 40);
                            },
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            subCategory.title,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
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
