import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/constants/app_text_styles.dart';

class CustomProfileMenu extends StatefulWidget {
  final String label;
  final double size;
  final Color backgroundColor;
  final IconData icon;
  final void Function() onTap;

  const CustomProfileMenu({
    super.key,
    required this.label,
    required this.size,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
  });

  @override
  State<CustomProfileMenu> createState() => _CustomProfileMenuState();
}

class _CustomProfileMenuState extends State<CustomProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          style: TextButton.styleFrom(
            fixedSize: const Size(200, 50),
            alignment: Alignment.centerLeft,
          ),
          onPressed: widget.onTap,
          label: Text(
            widget.label,
            style: TextStyle(
              fontSize: widget.size,
              fontWeight: FontWeight.w500,
              color: widget.backgroundColor,
              fontFamily: TextStyles.instance.secondary,
            ),
          ),
          icon: Icon(
            widget.icon,
            color: widget.backgroundColor,
            size: widget.size,
          ),
        ),
        Icon(Icons.arrow_forward_ios, color: widget.backgroundColor, size: 15),
      ],
    );
  }
}
