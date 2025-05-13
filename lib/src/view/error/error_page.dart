import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_text_styles.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String errorMessage =
        ModalRoute.of(context)?.settings.arguments as String? ??
        'Erro desconhecido';

    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 40,
            children: [
              Lottie.asset(
                'assets/animations/error.json',
                width: 200,
                height: 200,
              ),
              Text(
                'Ocorreu um erro inesperado',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: TextStyles.instance.primary,
                ),
              ),
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: TextStyles.instance.secondary,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouters.homePage);
                },
                child: Text(
                  'Voltar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: TextStyles.instance.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
