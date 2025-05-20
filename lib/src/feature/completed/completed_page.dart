import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_text_styles.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Concluídos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                fontFamily: TextStyles.instance.primary,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Nenhum chamado concluido ainda!',
              style: TextStyle(
                fontFamily: TextStyles.instance.secondary,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.secondaryColor.withAlpha(128),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
