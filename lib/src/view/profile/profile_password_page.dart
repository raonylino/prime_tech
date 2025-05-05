import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_text_styles.dart';
import 'package:prime_pronta_resposta/src/view/profile/cubit/profile_cubit.dart';
import 'package:prime_pronta_resposta/src/shared/custom_dual_buttom.dart';
import 'package:prime_pronta_resposta/src/shared/custom_texfield_pwd.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfilePasswordPage extends StatefulWidget {
  const ProfilePasswordPage({super.key});

  @override
  State<ProfilePasswordPage> createState() => _ProfilePasswordPageState();
}

class _ProfilePasswordPageState extends State<ProfilePasswordPage> {
  late TextEditingController newPwdController;
  late TextEditingController confirmPwdController;

  @override
  void initState() {
    super.initState();
    newPwdController = TextEditingController();
    confirmPwdController = TextEditingController();
  }

  @override
  void dispose() {
    newPwdController.dispose();
    confirmPwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(message: "Senha alterada com sucesso!"),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouters.profilePage,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                decoration: BoxDecoration(
                  color: AppColors.lightColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(250),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 100),
                      Column(
                        spacing: 20,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Image.asset('assets/images/prime_black.png'),
                          ),
                          Text(
                            'Alterar senha',
                            style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                              color: AppColors.secondaryColor,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTexfieldPwd(
                            label: 'Nova senha',
                            hintText: 'digite sua nova senha',
                            backgroundColor: AppColors.fourthColor,
                            controller: newPwdController,
                          ),
                          CustomTexfieldPwd(
                            label: 'Confirmar senha',
                            hintText: 'confirme sua nova senha',
                            backgroundColor: AppColors.fourthColor,
                            controller: confirmPwdController,
                          ),
                        ],
                      ),
                      state is ProfileLoading
                          ? const CircularProgressIndicator()
                          : CustomDualButtom(
                            labelText1: 'Voltar',
                            labelText2: 'Salvar',
                            onTap1: () => Navigator.pop(context),
                            onTap2: () {
                              context.read<ProfileCubit>().changePassword(
                                newPwdController.text,
                                confirmPwdController.text,
                              );
                            },
                            backgroundColor: AppColors.primaryColor,
                            icon1: Icons.arrow_back,
                            icon2: Icons.check_rounded,
                          ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
