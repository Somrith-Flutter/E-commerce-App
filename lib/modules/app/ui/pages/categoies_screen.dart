import 'package:flutter/material.dart';

class CategoiesScreen extends StatefulWidget {
  const CategoiesScreen({super.key});

  @override
  State<CategoiesScreen> createState() => _CategoiesScreenState();
}

class _CategoiesScreenState extends State<CategoiesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Categoies-Screen"),
      ),
    );
  }
}
