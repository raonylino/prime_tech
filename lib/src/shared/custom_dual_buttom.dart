import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_text_styles.dart';

class CustomDualButtom extends StatefulWidget {
  final String labelText1;
  final String labelText2;
  final IconData? icon1;
  final IconData? icon2;
  final Color? backgroundColor;
  final void Function() onTap1;
  final void Function() onTap2;

  const CustomDualButtom({
    super.key,
    required this.labelText1,
    required this.labelText2,
    this.icon1,
    this.icon2,
    this.backgroundColor,
    required this.onTap1,
    required this.onTap2,
  });

  @override
  State<CustomDualButtom> createState() => _CustomDualButtomState();
}

class _CustomDualButtomState extends State<CustomDualButtom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                fixedSize: const Size(150, 50),
                backgroundColor: AppColors.fourthColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: widget.onTap1,
              label: Text(
                widget.labelText1,
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: TextStyles.instance.secondary,
                ),
              ),
              icon:
                  widget.icon1 != null
                      ? Icon(
                        widget.icon1,
                        color: AppColors.primaryColor,
                        size: 20,
                      )
                      : const SizedBox.shrink(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 50),
                backgroundColor:
                    widget.backgroundColor ?? AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: widget.onTap2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.labelText2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: TextStyles.instance.secondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  widget.icon2 != null
                      ? Icon(widget.icon2, color: Colors.white, size: 20)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
