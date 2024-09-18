import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/layouts/error_404_widget.dart';
import 'package:market_nest_app/common/constants/api_path.dart';
import 'package:market_nest_app/app/ui/pages/product/view/product_view.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/controller/sub_category_controller.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/repository/sub_category_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubCategoriesScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const SubCategoriesScreen({required this.categoryId, required this.categoryName, super.key});
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
          style: const TextStyle(
            fontSize: 18
          ),
        ),
      ),
      body: Obx(() {
        if (subCategoryController.isLoading.value) {
          return Skeletonizer(
            enabled: subCategoryController.isLoading.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Item number $index as title'),
                      subtitle: const Text('Subtitle here'),
                      trailing: const Icon(Icons.ac_unit),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (subCategoryController.subCategories.isEmpty) {
          return const Error404Widget();
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
                    Get.to(ProductScreen(subCategoryId: subCategory.id, productName: subCategory.title,));
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
                            ApiPath.baseUrl() + subCategory.imageUrl,
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
