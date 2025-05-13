import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_colors.dart';

class CustomTexfield extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final Color? backgroundColor;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;

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
    this.inputFormatters,
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
            fontSize: 13,
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
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            fillColor: widget.backgroundColor ?? Colors.white,
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 13, color: AppColors.secondaryColor),
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
