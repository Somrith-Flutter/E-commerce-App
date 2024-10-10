import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/global_widgets/leading_app_bar_widget.dart';
import 'package:market_nest_app/app/ui/global_widgets/error_404_widget.dart';
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
        automaticallyImplyLeading: false,
        leading: leadingAppBarWidget(cc: context),
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
                String imageUrl = '${ApiPath.baseUrl()}${subCategoryController.subCategories[index].imageUrl}';
                return InkWell(
                  onTap: () {
                    Get.to(ProductScreen(subCategoryId: subCategory.id, productName: subCategory.tittle,));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0), 
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                            const Center(child: CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subCategory.tittle.toString(),
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
