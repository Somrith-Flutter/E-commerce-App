import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _buildPaymentOption('PayPal')),
                const Gap(8),
                Expanded(child: _buildPaymentOption('Google Pay')),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField('Card Holder Name', 'Enter card holder name'),
            const SizedBox(height: 16),
            _buildTextField('Card Number', '4111 1111 1111 1111'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField('Expiration', 'MM/YY')),
                const Gap(16),
                Expanded(child: _buildTextField('CVV', '123')),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                //primary: Colors.black,
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
