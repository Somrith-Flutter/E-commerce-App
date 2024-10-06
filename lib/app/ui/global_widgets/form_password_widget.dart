import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/theme_controller.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';

class FormPasswordWidget extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  const FormPasswordWidget({super.key, required this.label, required this.hint, required this.controller});
  @override
  State<FormPasswordWidget> createState() => _FormPasswordWidgetState();
}

class _FormPasswordWidgetState extends State<FormPasswordWidget> {
  bool isShow = false;
  final ThemeController _theme = Get.find<ThemeController>();

  void trigglePassword(){
    isShow =! isShow;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '${widget.label} ',
            style: TextStyle(
              fontSize: 16.0,
              color: _theme.isDarkMode.value ? Colors.white : Colors.black
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
          obscureText: isShow ? false : true,
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
            suffix: GestureDetector(
              onTap: () => trigglePassword(),
              child: Icon(
                  isShow ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill
              ),
            ),
          ),
        ),
      ],
    );
  }
}
