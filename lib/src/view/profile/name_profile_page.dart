import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/view/profile/controller_profile.dart';
import 'package:validatorless/validatorless.dart';

class NameProfilePage extends StatefulWidget {
  const NameProfilePage({super.key});

  @override
  State<NameProfilePage> createState() => _NameProfilePageState();
}

class _NameProfilePageState extends State<NameProfilePage> {
  final formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final bool success = false;

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: CustomScrollView(
            physics: const ScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Container(
                      width: screenSize.width,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            blurStyle: BlurStyle.normal,
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(6, 6),
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/pc_top.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.3,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/primeTech.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'alterar Nome do usuário',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: TextStyles.instance.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Preencha os campos abaixo para criar sua conta',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: TextStyles.instance.secondary,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        controller: _nameEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Nome obrigatório'),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Nome',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.person),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        validator: Validatorless.multiple([
                          Validatorless.required('nome obrigatório'),
                          Validatorless.compare(_nameEC, 'Email não confere'),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'confirmar nome',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.person),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                        child: SizedBox(
                      height: 20,
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenSize.width * .4,
                          decoration: BoxDecoration(
                            gradient: AppColors.gradientGrey,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .popAndPushNamed(RoutesAssets.profilePage);
                            },
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: TextStyles.instance.secondary,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: screenSize.width * .4,
                          decoration: BoxDecoration(
                            gradient: AppColors.gradient,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await ControllerProfile.updateUserName(
                                    _nameEC.text, (bool success) {
                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          'Alterado com sucesso',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily:
                                                TextStyles.instance.secondary,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    Navigator.of(context).popAndPushNamed(
                                        RoutesAssets.profilePage);
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Erro ao alterar',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily:
                                                TextStyles.instance.secondary,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                });
                              }
                            },
                            child: Text(
                              'Alterar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: TextStyles.instance.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
