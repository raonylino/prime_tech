import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/view/register/controller_register.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Form(
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
                      'Crie sua conta',
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
                        validator: Validatorless.required('Nome obrigatório'),
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
                        controller: _emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Email obrigatório'),
                          Validatorless.email('Email inválido'),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.email),
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
                        obscureText: true,
                        controller: _passwordEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha obrigatória'),
                          Validatorless.min(6, 'Mínimo de 6 caracteres'),
                          Validatorless.max(20, 'Máximo de 20 caracteres'),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.key),
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
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Confirme sua senha'),
                          Validatorless.compare(
                              _passwordEC, 'Senhas diferentes'),
                          Validatorless.min(6, 'Mínimo de 6 caracteres'),
                          Validatorless.max(20, 'Máximo de 20 caracteres'),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Confirme sua senha',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.key),
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
                      height: 30,
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
                                  .popAndPushNamed(RoutesAssets.loginPage);
                            },
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
                                final success =
                                    await ControllerRegister.registerUser(
                                        context,
                                        _emailEC.text,
                                        _passwordEC.text,
                                        _nameEC.text);
        
                                if (success != null) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Cadastro realizado com sucesso!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily:
                                              TextStyles.instance.secondary,
                                        ),
                                      ),
                                    ),
                                  );
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushReplacementNamed(
                                      RoutesAssets.loginPage);
                                }
                              }
                            },
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
