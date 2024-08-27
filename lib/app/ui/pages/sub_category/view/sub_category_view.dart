import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/ui/pages/product/view/product_view.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/controller/sub_category_controller.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/repository/sub_category_repository.dart';

class SubCategoriesScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  SubCategoriesScreen({required this.categoryId, required this.categoryName, super.key});
  @override
  Widget build(BuildContext context) {
    final SubCategoryController subCategoryController = Get.put(
      SubCategoryController(repository: SubCategoryRepository()),
    );

    subCategoryController.fetchSubCategories(categoryId: categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GridView.builder(
              itemCount: subCategoryController.subCategories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final subCategory = subCategoryController.subCategories[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(subCategoryId: subCategory.id),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0), 
                          color: Colors.grey[200], 
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0), 
                          child: Image.network(
                            ApiPath.baseUrl + subCategory.imageUrl,
                            width: double.infinity,
                            height: 140,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 80);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                );
              },
            ),
          );
        }
      }),
    );
  }
}
