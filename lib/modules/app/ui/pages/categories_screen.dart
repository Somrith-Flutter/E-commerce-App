import 'package:flutter/material.dart';
import 'package:market_nest_app/constants/app_constant.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<String> categories = [
    'Electronics',
    'Clothing',
    'Sports',
    'Books',
    'Home & Garden',
    'Home Decor',
    'Health',
    'Furniture',
  ];
  final List<String> icons = [
    'assets/icons/Electronic.png',
    'assets/icons/laundry.png',
    'assets/icons/balls-sports.png',
    'assets/icons/book.png',
    'assets/icons/house.png',
    'assets/icons/house-decoration.png',
    'assets/icons/healthcare.png',
    'assets/icons/sofa.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categories",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 2 / 2,
          ),
          itemBuilder: (context, index) {
            String iconPath;
            if (index < icons.length) {
              iconPath = icons[index];
            } else {
              iconPath = 'assets/icons/default.png';
            }

            return InkWell(
              onTap: () {
                print('Tapped on ${categories[index]}');
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
                      Image.asset(
                        iconPath,
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        categories[index],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
