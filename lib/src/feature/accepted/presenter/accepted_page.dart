import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_text_styles.dart';
import 'package:prime_pronta_resposta/src/core/dio/injection.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/presenter/cubit/accepted_cubit.dart';

class AcceptedPage extends StatelessWidget {
  const AcceptedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AcceptedCubit>(
      create: (_) => getIt<AcceptedCubit>()..fetchAccepted(),
      child: Scaffold(
        body: BlocBuilder<AcceptedCubit, AcceptedState>(
          builder: (context, state) {
            if (state is AcceptedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AcceptedLoaded) {
              return ListView.builder(
                itemCount: state.accepted.length,
                itemBuilder: (context, index) {
                  final accepted = state.accepted[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
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
                                'Você deseja abrir este chamado?',
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
                                    Navigator.of(
                                      context,
                                    ).popAndPushNamed('/home');
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
                                    Navigator.of(context).pushNamed(
                                      AppRouters.operationPage,
                                      arguments: accepted,
                                    );
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
                      child: Container(
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.lightColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withAlpha(50),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
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
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  accepted.title,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: TextStyles.instance.primary,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  accepted.companyName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: TextStyles.instance.secondary,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: AppColors.secondaryColor,
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is AcceptedError) {
              return Center(child: Text(state.message));
            }

            return Center(
              child: Text(
                'Nenhum chamado aceito!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: TextStyles.instance.primary,
                  color: AppColors.primaryColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
