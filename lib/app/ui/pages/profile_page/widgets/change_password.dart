import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
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
            const Text('Old Password', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildTextField('Enter your password'),
            const SizedBox(height: 16),
            const Text('New Password', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildTextField('Enter your new password'),
            _buildTextField('Confirm your new password'),
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

  Widget _buildTextField(String hint) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.visibility_off),
      ),
    );
  }
}
