import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_nest_app/app/ui/global_widgets/leading_app_bar_widget.dart';
import 'package:market_nest_app/common/constants/api_path.dart';
import 'package:market_nest_app/app/ui/global_widgets/text_widget.dart';
import 'package:market_nest_app/app/ui/pages/product/model/product_model.dart';
import 'package:gap/gap.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
    final PageController _controller = PageController();
    int currentPage = 0;

  int quantity = 0;
  List<Color> colors = [
    Colors.black,
    Colors.blueGrey,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.grey,
  ];
  Color selectedColor = Colors.blueGrey;
  final double sliverAppBarHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(16),
            if (sliverAppBarHeight != 200)
              Center(
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    ApiPath.baseUrl() + widget.product.imageUrl.toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 40);
                    },
                  ),
                ),
              ),
            const Row(
              children: [
                Chip(
                  backgroundColor: Colors.blue ,
                  label: TextWidget('Top Rated', color: Colors.white)),
                Gap(8),
                Chip(
                  backgroundColor: Color.fromARGB(255, 64, 229, 70) ,
                  label: TextWidget('Free Shipping', color: Colors.white,)
                ),
              ],
            ),
            const Gap(8),
            Text(
              widget.product.productName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(4),
            Row(
              children: [
                Text(
                  '\$${widget.product.prices.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                Text(
                  '\$${widget.product.discount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const Gap(4),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.amber, size: 20),
                Icon(Icons.star, color: Colors.grey, size: 20),
                Gap(8),
                Text('4.5 (2,495 reviews)', style: TextStyle(fontSize: 16)),
              ],
            ),
            const Gap(16),
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Read more'),
            ),

            const Gap(16),
            const Text(
              'Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Row(
              children: colors
                  .map(
                    (color) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedColor == color
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: color,
                          radius: 16,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const Gap(16),
            const Text(
              'Quantity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (quantity > 0) quantity--;
                      });
                    },
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Gap(24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                   
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: const Text('Buy Now'),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget('Add to Cart', color: Colors.white, bold: true,),
                        Gap(8),
                        Icon(Icons.shopping_cart_outlined, color: Colors.white,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    String imageUrlString = widget.product.imageUrl.toString();
    imageUrlString = imageUrlString
        .replaceAll('[', '["')
        .replaceAll(']', '"]')
        .replaceAll(', ', '","');
    List<String> imageUrls = List<String>.from(jsonDecode(imageUrlString));
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 250.0, 
      pinned: true,
      floating: false,
      snap: false,
      leading: leadingAppBarWidget(cc: context, background: true),
      title: Text(widget.product.productName.toString()),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: List.generate(imageUrls.length, (index) {
                return GestureDetector(
                  onTap: () {},
                  child: CachedNetworkImage(
                    imageUrl: ApiPath.baseUrl() + imageUrls[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                    const Center(child: CupertinoActivityIndicator()),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                );
              })
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
                child: imageUrls.isNotEmpty
                    ? SmoothPageIndicator(
                  controller: _controller,
                  count: imageUrls.length,
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
                    activeColorOverride: (i) => AppColors.blue,
                    inActiveColorOverride: (i) => AppColors.grey150,
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
}
