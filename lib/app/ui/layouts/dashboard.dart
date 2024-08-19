import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/ui/pages/category_page/categories_screen.dart';
import 'package:market_nest_app/app/ui/pages/home_page/home_screen.dart';
import 'package:market_nest_app/app/ui/pages/my_card_page/mycard_screen.dart';
import 'package:market_nest_app/app/ui/pages/profile_page/profile_page.dart';
import 'package:market_nest_app/app/ui/pages/wishlist_page/wishlist_screen.dart';

import '../../data/globle_variable/public_variable.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int visit = 0;
  final user = Get.find<AuthController>();

  List<TabItem> items = [
    const TabItem(
        icon: CupertinoIcons.home,
        title: "Home"
    ),
    const TabItem(
      icon: CupertinoIcons.square_grid_2x2,
      title: 'Categories',
    ),
    const TabItem(
      icon: CupertinoIcons.cart,
      title: 'My Card',
    ),
    const TabItem(
      icon: CupertinoIcons.heart,
      title: 'Wishlist',
    ),
    const TabItem(
      icon: CupertinoIcons.person,
      title: 'Profile',
    ),
  ];

  List<Widget> widgetsPage = [
    const HomeScreen(),
    const CategoriesScreen(),
    const MyCardScreen(),
    const WishListScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    user.getMeController(getToken: accessToken.$);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetsPage[visit],
      bottomNavigationBar: BottomBarCreative(
        items: items,
        backgroundColor: Colors.white,
        color: AppColors.grey150,
        colorSelected: AppColors.cyan,
        indexSelected: visit,
        isFloating: true,
        highlightStyle: const HighlightStyle(
            sizeLarge: true, isHexagon: true, elevation: 2),
        onTap: (int index) => setState(() {
          visit = index;
        }),
      ),
    );
  }
}
