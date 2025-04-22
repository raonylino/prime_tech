import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/view/shared/custom_texfield.dart';

class CustomTexfieldPwd extends StatefulWidget {
  final String label;
  final String hintText;
  final Color backgroundColor;
  final TextEditingController controller;

  const CustomTexfieldPwd({
    super.key,
    required this.label,
    required this.hintText,
    required this.backgroundColor,
    required this.controller,
  });

  @override
  State<CustomTexfieldPwd> createState() => _CustomTexfieldPwdState();
}

class _CustomTexfieldPwdState extends State<CustomTexfieldPwd> {
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTexfield(
      labelText: widget.label,
      hintText: widget.hintText,
      backgroundColor: widget.backgroundColor,
      controller: widget.controller,
      obscureText: obscureText,
      suffixIcon: IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
      ),
    );
  }
}
