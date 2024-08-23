import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> productImages = [
      'assets/images/apple_watch_series9.jpg',
      'assets/images/apple-watch-7-nike-black.jpg',
      // Add more image paths as needed
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildImageProductDetail(productImages),
                  buildBackground(),
                  buildBodyWidget(),
                  buildColorAndButton(),
                  SizedBox(height: 80), // Added space to ensure the buttons are visible
                ],
              ),
            ),
          ),
          buildButtons(), // Add buttons outside of SingleChildScrollView
        ],
      ),
    );
  }

  Widget buildImageProductDetail(List<String> productImages) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 240, // Increased height for better visibility
          child: PageView.builder(
            itemCount: productImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                productImages[index],
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(productImages.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: _currentImageIndex == index ? 12.0 : 8.0,
              height: _currentImageIndex == index ? 12.0 : 8.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentImageIndex == index ? AppColors.purple : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget buildBackground() {
    return Container(
      color: AppColors.cyan,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              buildTag("Top Rated", AppColors.blue),
              const SizedBox(width: 8),
              buildTag("Free Shipping", AppColors.purple),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Loop Silicone Strong Magnetic Watch",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$65.99",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "\$99.00",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            children: [
              SizedBox(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                "3.0(2499 reviews)",
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Constructed with high-quality silicone material, "
                "the Loop Silicone Strong Magnetic Watch ensures a "
                "comfortable and secure fit on your wrist. The soft "
                "and flexible silicone is gentle on the skin, making "
                "it ideal for extended wear. Its lightweight design allows "
                "for a seamless blend of comfort and durability.",
          ),
        ],
      ),
    );
  }

  Widget buildColorAndButton() {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    return Container(
      padding: const EdgeInsets.all(16.0), // Optional padding around the container
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Colors",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...colors.map((color) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 16,
                ),
              )).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildButtons() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Define action for 'Buy Now' button
            },
            child: const Text('Buy Now'),
          ),
          ElevatedButton(
            onPressed: () {
              // Define action for 'Add to Cart' button
            },
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
