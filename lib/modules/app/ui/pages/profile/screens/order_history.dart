import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildTabButton('Ongoing', true)),
                Expanded(child: _buildTabButton('Completed', false)),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildOrderItem('Loop Silicone Strong Magnetic Watch', '7 July, 2023', '\$15.25', '\$20.00'),
                  _buildOrderItem('M6 Smart Watch IP67 Waterproof', '7 July, 2023', '\$12.00', '\$18.00'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildOrderItem(String title, String date, String price, String originalPrice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            color: Colors.grey, // Placeholder for product image
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(date, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Row(
                children: [
                  Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Text(originalPrice, style: TextStyle(decoration: TextDecoration.lineThrough)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
