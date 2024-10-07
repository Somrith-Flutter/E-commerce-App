import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/pages/home/widgets/product_detail.dart';

class ExclusiveSales extends StatefulWidget {
  const ExclusiveSales({super.key});

  @override
  State<ExclusiveSales> createState() => _ExclusiveSalesState();
}

class _ExclusiveSalesState extends State<ExclusiveSales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exclusive Sales".tr,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            color: Colors.black,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildWidgetExclusiveSales(),
          ],
        ),
      ),
    );
  }

  Widget buildWidgetExclusiveSales() {
    final List<Map<String, dynamic>> products = [
      {
        "image": "assets/images/apple-watch-7-nike-black.jpg", // Replace with actual asset paths
        "title": "Apple Watch 7 Niki",
        "price": "\$15.25",
        "old_price": "\$20.00",
        "colors": [Colors.blue, Colors.green, Colors.purple]
      },
      {
        "image": "assets/images/apple_watch_series9.jpg",
        "title": "Apple Watch Series 9 Ultra",
        "price": "\$32.00",
        "old_price": "\$35.00",
        "colors": [Colors.grey, Colors.blue, Colors.black]
      },
      {
        "image": "assets/images/apple_watch_series9.jpg",
        "title": "K800 Ultra smart watch",
        "price": "\$32.00",
        "old_price": "\$35.00",
        "colors": [Colors.grey, Colors.blue, Colors.black]
      },
      {
        "image": "assets/images/apple-watch-7-nike-black.jpg", // Replace with actual asset paths
        "title": "Loop silicone strong",
        "price": "\$15.25",
        "old_price": "\$20.00",
        "colors": [Colors.blue, Colors.green, Colors.purple, Colors.greenAccent]
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling independently
        shrinkWrap: true, // Makes GridView take only the required space
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDetail()),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.asset(
                            product['image'], // Ensure the image path is correct
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 8,
                        top: 8,
                        child: Icon(Icons.favorite_border, color: Colors.black,),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['title'].toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      product['price'].toString(), // Convert to String
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      product['old_price'].toString(), // Convert to String
                      style: const TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      children: (product['colors'] as List<Color>).map<Widget>((color) {
                        return Container(
                          margin: const EdgeInsets.only(right: 4.0),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
