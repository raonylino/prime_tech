import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/constants/app_colors.dart';

class CustomTexfield extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  final Key? textFieldKey;

  const CustomTexfield({
    super.key,
    required this.labelText,
    this.hintText,
    this.backgroundColor,
    this.suffixIcon,
    required this.controller,
    required this.obscureText,
    this.validator,
    this.focusNode,
    this.textFieldKey,
  });

  @override
  State<CustomTexfield> createState() => _CustomTexfieldState();
}

class _CustomTexfieldState extends State<CustomTexfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          key: widget.textFieldKey,
          focusNode: widget.focusNode,
          validator: widget.validator,
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            fillColor: widget.backgroundColor ?? Colors.white,
            hintText: widget.hintText,
            filled: true,
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
