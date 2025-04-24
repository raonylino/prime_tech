import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/constants/app_text_styles.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 20),
          Text(
            'Pendentes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: TextStyles.instance.primary,
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppColors.lightColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: const Text('Confirmação'),
                        content: Text(
                          'Você deseja aceitar este chamado?',
                          style: TextStyle(
                            fontFamily: TextStyles.instance.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightColor,
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).popAndPushNamed('/home');
                            },
                            child: Text(
                              'Não',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextStyles.instance.secondary,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRouters.operationPage);
                              // Lógica para aceitar
                              print('Chamado aceito');
                            },
                            child: Text(
                              'Sim',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextStyles.instance.secondary,
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 72,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withAlpha(
                          (0.2 * 255).round(),
                        ),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    color: AppColors.lightColor,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.directions_car,
                            color: AppColors.textColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Carro 1',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: TextStyles.instance.primary,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              'Dados do carro',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextStyles.instance.secondary,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: AppColors.textColor,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
