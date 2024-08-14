import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:market_nest_app/config/themes/app_color.dart';
import 'package:market_nest_app/modules/app/ui/pages/categoies_screen.dart';
import 'package:market_nest_app/modules/app/ui/pages/home_screen.dart';
import 'package:market_nest_app/modules/app/ui/pages/mycard_screen.dart';
import 'package:market_nest_app/modules/app/ui/pages/profile_screen.dart';
import 'package:market_nest_app/modules/app/ui/pages/wishlist_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int visit = 0;

  List<TabItem> items = [
    const TabItem(
        icon: CupertinoIcons.home,
        title: "Home"
    ),
    const TabItem(
      icon: CupertinoIcons.square_grid_2x2,
      title: 'Categoies',
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
    const CategoiesScreen(),
    const MyCardScreen(),
    const WishListScreen(),
    const ProfileScreen(),
  ];

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
