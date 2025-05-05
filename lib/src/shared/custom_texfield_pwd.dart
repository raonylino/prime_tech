import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/shared/custom_texfield.dart';
import 'package:validatorless/validatorless.dart';

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
      validator: Validatorless.multiple([
        Validatorless.required('Campo obrigatório'),
        Validatorless.min(8, 'Senha deve ter no mínimo 8 caracteres'),
      ]),
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
