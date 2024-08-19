import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFAQItem('Can I cancel my order?', 'Yes, only if the order is not dispatched yet. You can contact our customer service department to get your order canceled.'),
          _buildFAQItem('Will I receive the same product I see in the photo?', 'Actual product color may vary from the images shown...'),
          _buildFAQItem('How can I recover the forgotten password?', 'If you have forgotten your password, you can recover it from the "Login - Forgotten your password?" section.'),
          _buildFAQItem('Is my personal information confidential?', 'Your personal information is confidential. We do not rent, sell, barter or trade email addresses.'),
          _buildFAQItem('What payment methods can I use to make purchases?', 'We offer the following payment methods: PayPal, VISA, MasterCard, and Voucher code, if applicable.'),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(answer),
        ],
      ),
    );
  }
}
