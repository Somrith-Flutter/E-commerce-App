import 'package:flutter/material.dart';

class MyCardScreen extends StatefulWidget {
  const MyCardScreen({super.key});

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("MyCard-Screen"),
      ),
    );
  }
}
