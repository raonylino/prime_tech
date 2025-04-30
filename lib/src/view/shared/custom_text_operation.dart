import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/constants/app_text_styles.dart';

class CustomTextOperation extends StatefulWidget {
  final String title;
  final String description;
  const CustomTextOperation({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<CustomTextOperation> createState() => _CustomTextOperationState();
}

class _CustomTextOperationState extends State<CustomTextOperation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontFamily: TextStyles.instance.secondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
        Text(
          widget.description,
          style: TextStyle(
            fontFamily: TextStyles.instance.secondary,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
