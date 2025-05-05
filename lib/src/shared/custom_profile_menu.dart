import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_text_styles.dart';

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
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  widget.icon,
                  color: widget.backgroundColor,
                  size: widget.size,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: widget.size,
                    fontWeight: FontWeight.w500,
                    color: widget.backgroundColor,
                    fontFamily: TextStyles.instance.secondary,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: widget.backgroundColor,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
