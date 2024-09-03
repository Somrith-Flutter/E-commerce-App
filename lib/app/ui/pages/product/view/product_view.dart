import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/theme_controller.dart';
import 'package:market_nest_app/app/data/api/api_path.dart';
import 'package:market_nest_app/app/ui/pages/home/controller/home_controller.dart';
import 'package:market_nest_app/app/ui/pages/product/controller/product_controller.dart';
import 'package:market_nest_app/app/ui/pages/product/repository/product_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductScreen extends StatefulWidget {
  final int? subCategoryId;
  final String? productName;
  final bool? getAll;
  const ProductScreen({this.subCategoryId, this.productName, this.getAll = false, super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductController productController = Get.put(
    ProductController(repository: ProductRepository()),
  );
  final _themeController = Get.find<ThemeController>();
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    if(widget.getAll == false){
      productController.fetchProducts(subCategoryId: widget.subCategoryId??0);
    }else{
      print("rest full");
      productController.fetchedProductByLength(0.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.productName != null &&
          widget.productName != "null" && widget.productName!.isNotEmpty
            ? "${widget.productName} Products"
            : "Products",
          style: const TextStyle(
            fontSize: 18
          ),
        ),
        actions: [
          IconButton(onPressed: (){},
            icon: const Icon(CupertinoIcons.search)),
          const Gap(5),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Skeletonizer(
            enabled: productController.isLoading.value,
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
        } else if (productController.products.isEmpty) {
          return const Center(child: Text('No products available.'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: productController.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder: (context, index) {
                final product = productController.products[index];
                return GestureDetector(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                ApiPath.baseUrl + product.imageUrl,
                                width: MediaQuery.of(context).size.width,
                                height: 160,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image, size: 40);
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(100))
                              ),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: (){},
                                icon: const Icon(CupertinoIcons.heart,)),
                            ),
                          )
                        ],
                      ),
                      const Gap(5),
                      Text(
                        product.productName,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: _themeController.currentTheme.value != ThemeMode.light ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const Gap(5),
                      Text(
                        product.description,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: _themeController.currentTheme.value != ThemeMode.light ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "\$ ${product.prices.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: _themeController.currentTheme.value != ThemeMode.light ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "\$ ${product.discount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
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
