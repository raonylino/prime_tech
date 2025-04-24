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
import 'package:prime_pronta_resposta/src/view/shared/custom_texfield_pwd.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

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
        },
        builder: (context, state) {
          String name = '';
          String email = '';
          String? phone = '';

          if (state is ProfileLoading) {
            return const Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          } else if (state is ProfileLoaded) {
            name = state.name;
            email = state.email;
            phone = state.phone;
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
                        Column(
                          children: [
                            const SizedBox(height: 100),
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
                          ],
                        ),
                        Column(
                          spacing: 20,
                          children: [
                            CustomTexfield(
                              labelText: 'Nome',
                              backgroundColor: AppColors.fourthColor,
                              controller: TextEditingController(
                                text: name == '' ? null : name,
                              ),
                              obscureText: false,
                            ),
                            CustomTexfield(
                              labelText: 'Email',
                              backgroundColor: AppColors.fourthColor,
                              controller: TextEditingController(
                                text: email == '' ? null : email,
                              ),
                              obscureText: false,
                            ),
                            CustomTexfield(
                              labelText: 'Telefone',
                              backgroundColor: AppColors.fourthColor,
                              controller: TextEditingController(
                                text: phone == '' ? null : phone,
                              ),
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
                          onTap1: () => Navigator.pop(context),
                          onTap2: () {
                            Navigator.pop(context);
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
