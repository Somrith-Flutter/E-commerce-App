import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Old Password', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildTextField('Enter your password'),
            SizedBox(height: 16),
            Text('New Password', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildTextField('Enter your new password'),
            _buildTextField('Confirm your new password'),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                //primary: Colors.black,
              ),
              child: Text('Save'),
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
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.visibility_off),
      ),
    );
  }
}
