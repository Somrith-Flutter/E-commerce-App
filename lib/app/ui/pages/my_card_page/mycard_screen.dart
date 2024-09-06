import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:market_nest_app/app/ui/global_widgets/text_widget.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';

class MyCardScreen extends StatelessWidget {
  const MyCardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/empty_cart.png', 
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 32),
              const TextWidget(
                'Your cart is empty',
                size: 22,
                bold: true,
              ),
              const Gap(16),
              const TextWidget(
                'Looks like you have not added anything in your cart. '
                'Go ahead and explore top categories.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryBlack,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const TextWidget(
                    'Explore Categories',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
