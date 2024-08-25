import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/pages/home_page/widgets/exclusive_sales.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/app/config/constants/app_constant.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _user = Get.find<AuthController>();
  AuthController get user => _user;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppConstant.appName, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: NetworkImage('https://i.pinimg.com/564x/86/a8/ef/86a8ef5ff3a046bfd168695b6e9d6608.jpg')),
            onPressed: () {
              if(user.newUserModel != null){
                print("id : ${user.newUserModel?.name.toString()}");
              }else{
                print("user null");
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPromotionalBanner(),
            _buildCategoriesSection(),
            _buildLatestProductsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionalBanner() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ExclusiveSales()));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: NetworkImage('https://cdn.mos.cms.futurecdn.net/fsDKHB3ZyNJK6zMpDDBenB.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  '30% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'On Headphones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Exclusive Sales',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == 0 ? AppColors.cyan : Colors.white54,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Categories', onSeeAllPressed: () {}),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCategoryIcon(Icons.phone_android, 'Electronics'),
              _buildCategoryIcon(Icons.shopping_bag, 'Fashion'),
              _buildCategoryIcon(Icons.home, 'Furniture'),
              _buildCategoryIcon(Icons.car_rental, 'Industrial'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLatestProductsSection() {
    String url = 'https://img.freepik.com/premium-photo/beautiful-cute-anime-girl-innocent-anime-teenage_744422-6819.jpg?w=360';
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Latest Products', onSeeAllPressed: () {}),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildProductCard('Nike Air Jordan Retro', '\$126.00', '\$186.00', 5, url),
              _buildProductCard('Classic Black Glasses', '\$8.50', '\$10.00', 7, url),
              _buildProductCard('P47 Wireless Headphones', '\$38.45', '\$42.75', 3, url),
              _buildProductCard('Brown Box Luxury Bag', '\$98.00', '\$122.00', 1, url),
            ],
          ),
        ],
      ),
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
          child: const Text('SEE ALL'),
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

  Widget _buildProductCard(String title, String price, String oldPrice, int colors, String imagePath) {
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
                  children: List.generate(colors, (index) => const Icon(Icons.circle, size: 8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
