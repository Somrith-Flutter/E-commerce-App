import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          "assets/images/logo_mn.png",
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 36),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.photo, color: Colors.black, size: 26),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.lightBlueAccent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      // Example of a child widget inside the container
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Categories".tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(width: 150,),
                  Text(
                    "SEE ALL".tr,
                    style: const TextStyle(fontSize: 16,
                        color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 4, // 4 columns
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(4, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(width: 1.0, color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        'Item ${index + 1}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Latest Products".tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(width: 100,),
                  Text(
                    "SEE ALL".tr,
                    style: const TextStyle(fontSize: 16,
                        color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(8, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                     color: Colors.pinkAccent
                    ),
                    child: Center(
                      child: Text(
                        'Item ${index + 1}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
