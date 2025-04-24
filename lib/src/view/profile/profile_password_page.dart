import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/constants/app_text_styles.dart';
import 'package:prime_pronta_resposta/src/view/shared/custom_dual_buttom.dart';
import 'package:prime_pronta_resposta/src/view/shared/custom_texfield_pwd.dart';

class ProfilePasswordPage extends StatelessWidget {
  const ProfilePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: BoxDecoration(
            color: AppColors.lightColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(250)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 40,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 100),
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
                  ],
                ),
                Column(
                  spacing: 20,
                  children: [
                    CustomTexfieldPwd(
                      label: 'Senha atual',
                      hintText: 'digite sua senha atual',
                      backgroundColor: AppColors.fourthColor,
                      controller: TextEditingController(),
                    ),
                    CustomTexfieldPwd(
                      label: 'Nova senha',
                      hintText: 'digite sua nova senha',
                      backgroundColor: AppColors.fourthColor,
                      controller: TextEditingController(),
                    ),
                    CustomTexfieldPwd(
                      label: 'Confirmar senha',
                      hintText: 'confirme sua nova senha',
                      backgroundColor: AppColors.fourthColor,
                      controller: TextEditingController(),
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
    );
  }
}
