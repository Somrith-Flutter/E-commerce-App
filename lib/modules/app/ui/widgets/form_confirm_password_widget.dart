import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:market_nest_app/config/themes/app_color.dart';

class FormConfirmPasswordWidget extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  const FormConfirmPasswordWidget({super.key, required this.label, required this.hint, required this.controller});

  @override
  State<FormConfirmPasswordWidget> createState() => _FormConfirmPasswordWidgetState();
}

class _FormConfirmPasswordWidgetState extends State<FormConfirmPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '${widget.label} ',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        TextField(
          controller: widget.controller,
          obscureText: true,
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 22.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: AppColors.cyan,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: AppColors.cyan,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: AppColors.cyan,
                width: 2.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
