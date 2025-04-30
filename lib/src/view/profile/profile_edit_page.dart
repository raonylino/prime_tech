import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/constants/app_text_styles.dart';
import 'package:prime_pronta_resposta/src/view/profile/cubit/profile_cubit.dart';
import 'package:prime_pronta_resposta/src/view/shared/custom_dual_buttom.dart';
import 'package:prime_pronta_resposta/src/view/shared/custom_texfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ProfileCubit()..loadUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            Navigator.of(
              context,
            ).pushNamed(AppRouters.errorPage, arguments: state.message);
          }

          if (state is ProfileLoaded) {
            nameController.text = state.name;
            emailController.text = state.email;
            phoneController.text = state.phone ?? '';
          }

          if (state is ProfileUpdateSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.success(message: "Perfil atualizado com sucesso!"),
            );
          } else if (state is ProfileError) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: "Erro ao atualizar perfil!",
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          } else if (state is ProfileLoaded) {
            nameController.text = state.name;
            emailController.text = state.email;
            phoneController.text = state.phone ?? '';
          }

          return SafeArea(
            top: false,
            child: Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  decoration: BoxDecoration(
                    color: AppColors.lightColor,
                    borderRadius: BorderRadius.only(
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
                      spacing: 40,
                      children: [
                        Column(children: [const SizedBox(height: 100)]),
                        Column(
                          spacing: 20,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              child: Image.asset(
                                'assets/images/prime_black.png',
                              ),
                            ),
                            Text(
                              'Editar Perfil',
                              style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                color: AppColors.secondaryColor,
                                fontFamily: TextStyles.instance.secondary,
                              ),
                            ),
                            CustomTexfield(
                              labelText: 'Nome',
                              backgroundColor: AppColors.fourthColor,
                              controller: nameController,
                              obscureText: false,
                            ),
                            CustomTexfield(
                              labelText: 'Email',
                              backgroundColor: AppColors.fourthColor,
                              controller: emailController,
                              obscureText: false,
                            ),
                            CustomTexfield(
                              labelText: 'Telefone',
                              backgroundColor: AppColors.fourthColor,
                              controller: phoneController,
                              obscureText: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter(),
                              ],
                            ),
                          ],
                        ),
                        CustomDualButtom(
                          labelText1: 'Voltar',
                          labelText2: 'Salvar',
                          onTap1:
                              () =>
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRouters.profilePage,
                                    (route) => false,
                                  ),
                          onTap2: () {
                            context.read<ProfileCubit>().updateUserProfile(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
