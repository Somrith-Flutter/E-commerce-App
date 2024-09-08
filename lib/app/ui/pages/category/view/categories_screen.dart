import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/theme_controller.dart';
import 'package:market_nest_app/common/constants/api_path.dart';
import 'package:market_nest_app/app/ui/pages/category/controller/category_controller.dart';
import 'package:market_nest_app/app/ui/pages/category/repository/category_repository.dart';
import 'package:market_nest_app/app/ui/pages/category/model/category_model.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/view/sub_category_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesScreen extends StatefulWidget {
  final bool? isFromSeeAll;
  const CategoriesScreen({super.key, this.isFromSeeAll = false});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoryController categoryController =
      Get.put(CategoryController(repository: CategoryRepository()));
  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFromSeeAll == true ? AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon( Platform.isAndroid ?
           CupertinoIcons.arrow_left
           : CupertinoIcons.back
          )
        ),
        title: const Text(
          "Categories",
        ),
      ) : AppBar(
        title: const Text(
          "Categories",
        ),
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return Skeletonizer(
            enabled: categoryController.isLoading.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 7,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubCategoriesScreen(categoryId: category.id, categoryName: category.name,),
                      ),
                    );
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
                              return const Icon(Icons.broken_image, size: 40);
                            },
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: _themeController.currentTheme.value != ThemeMode.light ? Colors.black : Colors.brown,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                              category.description,
                              style: TextStyle(
                                color: _themeController.currentTheme.value != ThemeMode.light ? Colors.black : Colors.brown,
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
