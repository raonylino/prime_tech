import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_text_styles.dart';
import 'package:prime_pronta_resposta/src/core/dio/injection.dart';
import 'package:prime_pronta_resposta/src/widget/custom_text_operation.dart';
import 'package:prime_pronta_resposta/src/view/operation/presenter/cubit/operation_cubit.dart';
import 'package:prime_pronta_resposta/src/view/pending/data/model/pending_model.dart';

class OperationPage extends StatelessWidget {
  final PendingModel pending;
  const OperationPage({super.key, required this.pending});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => getIt<OperationCubit>()..fetchOperationById(pending.id),
      child: BlocBuilder<OperationCubit, OperationState>(
        builder: (context, state) {
          if (state is OperationLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is OperationError) {
            return Scaffold(
              body: Center(
                child: Text('Erro ao carregar dados: ${state.message}'),
              ),
            );
          } else if (state is OperationLoaded) {
            final pending = state.operation;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Operações',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontFamily: TextStyles.instance.primary,
                  ),
                ),
                centerTitle: true,
                backgroundColor: AppColors.primaryColor,
                actionsIconTheme: const IconThemeData(color: Colors.white),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        collapsedBackgroundColor: AppColors.thirdColor,
                        backgroundColor: AppColors.thirdColor,
                        title: Text(
                          'Detalhes do atendimento',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: TextStyles.instance.primary,
                            color: Colors.black45,
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextOperation(
                                    title: 'Tipo de atendimento:',
                                    description: '',
                                  ),
                                  CustomTextOperation(
                                    title: 'Local da ocorrência:',
                                    description:
                                        '${pending.address}, ${pending.number} - ${pending.uf}',
                                  ),
                                  CustomTextOperation(
                                    title: 'Mercadoria:',
                                    description: pending.goods.first,
                                  ),
                                  CustomTextOperation(
                                    title: 'Transporte:',
                                    description: pending.shippingCompanyName,
                                  ),
                                  CustomTextOperation(
                                    title: 'Placa carreta:',
                                    description: 'HDF 1234',
                                  ),
                                  CustomTextOperation(
                                    title: 'Placa do Cavalo:',
                                    description: 'ABC 1234',
                                  ),
                                  CustomTextOperation(
                                    title: 'Cidade da ocorrência:',
                                    description: pending.city,
                                  ),
                                  CustomTextOperation(
                                    title: 'UF da ocorrência:',
                                    description: pending.uf,
                                  ),

                                  CustomTextOperation(
                                    title: 'Latitude / Longitude:',
                                    description:
                                        '${pending.latitude} / ${pending.longitude}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        collapsedBackgroundColor: AppColors.thirdColor,
                        backgroundColor: AppColors.thirdColor,
                        title: Text(
                          'Lista de atendimento',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: TextStyles.instance.primary,
                            color: Colors.black45,
                          ),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Text(
                              'Nenhuma Lista de atendimento ainda!',
                              style: TextStyle(
                                fontFamily: TextStyles.instance.secondary,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
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
                              'Você realmente deseja iniciar a ocorrência?',
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
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
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
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushNamed(
                                    context,
                                    AppRouters.dateOperationPage,
                                  );
                                },
                                child: const Text(
                                  'Confirmar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'iniciar ocorrência',
                      style: TextStyle(
                        fontFamily: TextStyles.instance.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
          return const SizedBox.shrink(); // fallback
        },
      ),
    );
  }
}
