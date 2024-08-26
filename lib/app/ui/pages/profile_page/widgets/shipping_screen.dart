import 'package:flutter/material.dart';
import 'package:market_nest_app/app/ui/global_widgets/my_textInput.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';

class ShippingAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Address'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildNameField(),
              const SizedBox(height: 12),
              buildAddressAndPhoneFields(),
              const SizedBox(height: 12),
              buildCityAndProvince(),
              const SizedBox(height: 12),
              buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNameField() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        MyTextInput(
          xLabel: "Full Name",
          isRequired: true,
          hintText: "Please Input Full Name",
          xSize: 18,
        ),
      ],
    );
  }

  Widget buildAddressAndPhoneFields() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        MyTextInput(
          xLabel: "Phone Number",
          isRequired: true,
          hintText: "Enter Your Phone Number",
          xSize: 18,
          prefixIcon: Icon(Icons.arrow_drop_down),
        ),
        SizedBox(height: 20.0),
        MyTextInput(
          xLabel: "Province",
          isRequired: true,
          hintText: "Select Province",
          xSize: 18,
          prefixIcon: Icon(Icons.arrow_drop_down),
        ),
        SizedBox(height: 20.0),
        MyTextInput(
          xLabel: "City",
          isRequired: true,
          hintText: "Select City",
          xSize: 18,
          prefixIcon: Icon(Icons.arrow_drop_down),
        ),
      ],
    );
  }

  Widget buildCityAndProvince() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        MyTextInput(
          xLabel: "Street Address",
          isRequired: true,
          hintText: "Enter street address",
          xSize: 18,
        ),
        SizedBox(height: 20),
        MyTextInput(
          xLabel: "Postal Code",
          isRequired: true,
          hintText: "Enter postal code",
          xSize: 18,
        ),

      ],
    );
  }

  Widget buildSubmitButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 160),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Save',
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
      ),
    );
  }
}
