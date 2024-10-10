import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/config/app_object_list.dart';
import 'package:market_nest_app/app/controllers/theme_controller.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/ui/global_widgets/error_404_widget.dart';
import 'package:market_nest_app/app/ui/pages/category/controller/category_controller.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/controller/sub_category_controller.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/common/constants/api_path.dart';
import 'package:market_nest_app/app/ui/pages/category/model/category_model.dart';
import 'package:market_nest_app/app/ui/pages/category/view/categories_screen.dart';
import 'package:market_nest_app/app/ui/pages/home/controller/home_controller.dart';
import 'package:market_nest_app/app/ui/pages/home/widgets/exclusive_sales.dart';
import 'package:market_nest_app/app/ui/pages/product/view/product_details_view.dart';
import 'package:market_nest_app/app/ui/pages/product/view/product_view.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/view/sub_category_view.dart';
import 'package:market_nest_app/common/constants/app_constant.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _user = Get.find<AuthController>();

  AuthController get user => _user;
  final _themeController = Get.find<ThemeController>();
  final PageController _controller = PageController();
  final sub = Get.find<SubCategoryController>();
  final cate = Get.find<CategoryController>();
  final product = Get.find<HomeController>();
  int currentPage = 0;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), (){
      sub.getSlide(active: "1");
      cate.fetchCategories();
      product.fetchedProductByLength(5.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const Text(AppConstant.appName),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.white,),
              onPressed: () {},
            ),
            IconButton(
              icon: const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pinimg.com/564x/86/a8/ef/86a8ef5ff3a046bfd168695b6e9d6608.jpg')),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPromotionalBanner(),
              _buildCategoriesSection(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildSectionHeader(
                    'Latest Products', onSeeAllPressed: () {
                  Get.to(const ProductScreen(getAll: true,));
                }),
              ),
              _buildLatestProductsSection(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPromotionalBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 200,
        child: Stack(
          children: [
            PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                children: List.generate(sub.slideBanner.length, (index) {
                  if (sub.status == Status.fail) {
                    return CupertinoActivityIndicator(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    );
                  }

                  if (sub.status == Status.success) {
                    String imageUrl = '${ApiPath.baseUrl()}${sub.slideBanner[index].imageSlide}';
                    return GestureDetector(
                      onTap: () {
                        Get.to(ProductScreen(subCategoryId: sub.slideBanner[index].id, productName: sub.slideBanner[index].tittle,));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
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
                    );
                  }

                  return const SizedBox.shrink();
                },)
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(7),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: sub.slideBanner.isNotEmpty
                  ? SmoothPageIndicator(
                  controller: _controller,
                  count: sub.slideBanner.length,
                  effect: CustomizableEffect(
                    activeDotDecoration: DotDecoration(
                      width: 10,
                      height: 10,
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2),
                      rotationAngle: 45,
                      dotBorder: const DotBorder(
                        padding: 2,
                        width: 2,
                        color: Colors.indigo,
                      ),
                    ),
                    dotDecoration: DotDecoration(
                      width: 12,
                      height: 12,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                      dotBorder: const DotBorder(
                        padding: 2,
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    spacing: 10.0,
                    activeColorOverride: (i) => colors[i],
                    inActiveColorOverride: (i) => colors[i],
                  ),
                )
                  : const SizedBox.shrink(),
              ),
            )
          ],
        ),
      ),
    );
  }

  final HomeController homeController = Get.find<HomeController>();
  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Categories', onSeeAllPressed: () {
            Get.to(const CategoriesScreen(isFromSeeAll: true));
          }),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeController.categories.length,
              itemBuilder: (context, index) {
                final category = homeController.categories[index];

                if(homeController.isLoading.value){
                  SizedBox(
                    height: 200,
                    child: Skeletonizer(
                      enabled: homeController.isLoading.value,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text('Loading $index...'),
                              subtitle: const Text('Loading subtitle...'),
                              trailing: const Icon(Icons.ac_unit),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }

                if(homeController.categories.isEmpty){
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No categories available'),
                    ),
                  );
                }

                return _buildCategoryItem(category);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryItem(CategoryModel category) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategoriesScreen(
              categoryId: category.id, categoryName: category.name,),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Image.network(
                ApiPath.baseUrl() + category.imageUrl,
                width: 40.0,
                height: 40.0,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 40);
                },
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLatestProductsSection() {
    HomeController productController = Get.find<HomeController>();
    final themeController = Get.find<ThemeController>();
    return productController.isLoading.value
      ? Skeletonizer(
        enabled: productController.isLoading.value,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
      )
      : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: productController.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 2 / 3,
          ),
          itemBuilder: (context, index) {
            final product = productController.products[index];
            if (productController.products.isEmpty) {
              return const Error404Widget();
            }

            return GestureDetector(
              onTap: () {
                Get.to(ProductDetailsView(product: product,));
              },
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
                          child: CachedNetworkImage(
                            imageUrl: "${ApiPath.baseUrl()}${productController.products[index].imageThumbnail.toString()}",
                            placeholder: (context, url) => const CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.withOpacity(0.8)
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                                product.addFavorite.toString() != "1" ?
                              CupertinoIcons.heart : CupertinoIcons.heart_fill,
                              color: product.addFavorite.toString() != "0"
                              ? AppColors.red : AppColors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(2),
                  Text(
                    product.productName,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: themeController.currentTheme.value !=
                          ThemeMode.light ? Colors.white : Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const Gap(5),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: themeController.currentTheme.value !=
                          ThemeMode.light ? Colors.white : Colors.black,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "\$ ${product.prices.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: themeController.currentTheme.value !=
                          ThemeMode.light ? Colors.white : Colors.black,
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
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        )
      );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onSeeAllPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: Text('SEE ALL', style: TextStyle(
            color: _themeController.currentTheme.value != ThemeMode.light
                ? Colors.white
                : Colors.black,
          ),),
        ),
      ],
    );
  }

  Widget _buildCategoryIcon(IconData iconData, String label) {
    return Column(
      children: [
        Icon(iconData, size: 40),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildProductCard(String title, String price, String oldPrice,
      int colors, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(imagePath, fit: BoxFit.cover),
                ),
                const Positioned(
                  right: 8,
                  top: 8,
                  child: Icon(Icons.favorite_border),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  oldPrice,
                  style: const TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                      colors, (index) => const Icon(Icons.circle, size: 8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
