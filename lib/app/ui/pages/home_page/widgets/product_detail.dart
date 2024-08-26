import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _currentImageIndex = 0;
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> productImages = [
      'assets/images/apple01.jpg',
      'assets/images/apple02.jpg',
      'assets/images/apple03.jpg'

    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details".tr),
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
                  // buildBackground(),
                  buildBodyWidget(),
                  buildColorAndButton(),
                  buildButtons(),
                ],
              ),
            ),
          ),
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
          child: Stack(
            children: [
              PageView.builder(
                itemCount: productImages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    productImages[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
              Positioned(
                bottom: 0,
                left: MediaQuery.sizeOf(context).width/2.5,
                child: Row(
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
              ),
            ],
          ),
        ),
      ],
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
              const SizedBox(width: 10.0),
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
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Colors",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
          const SizedBox(height: 10,),
          const Text("Quantity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          const SizedBox(height: 10.0,),
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  width: 1,color: Colors.black,
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_quantity > 0) {
                        _quantity--;}
                    });
                  },
                  color: Colors.grey,
                  padding: const EdgeInsets.all(0),
                ),
                Text(
                  '$_quantity',
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _quantity++;}
                    );
                  },
                  color: Colors.black,
                  padding: const EdgeInsets.all(0),
                ),
              ],
            ),
          )
        ],
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
            onPressed: () { },
            child: const Text('Buy Now',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Add to Cart',style: TextStyle(fontWeight: FontWeight.bold),),
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
}
