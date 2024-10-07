import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/pages/home/view/home_view.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/ui/pages/category/view/categories_screen.dart';
import 'package:market_nest_app/app/ui/pages/my_card_page/view/mycard_screen.dart';
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
    TabItem(
        icon: CupertinoIcons.home,
        title: 'home'.tr
    ),
    TabItem(
      icon: CupertinoIcons.square_grid_2x2,
      title: 'category'.tr,
    ),
    const TabItem(
      icon: CupertinoIcons.cart,
      title: 'My Card',
    ),
    TabItem(
      icon: CupertinoIcons.heart,
      title: 'favorite'.tr,
    ),
     TabItem(
      icon: CupertinoIcons.person,
      title: 'my_account'.tr,
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
    initMe();
    super.initState();
  }

  void initMe() async {
    await user.refreshTokenController().then((_){
      user.getMeController(getToken: accessToken.$);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetsPage[visit],
      bottomNavigationBar: BottomBarCreative(
        items: items,
        backgroundColor: AppColors.primaryWhite,
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
