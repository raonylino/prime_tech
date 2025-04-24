import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:prime_pronta_resposta/src/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/constants/app_text_styles.dart';
import 'package:prime_pronta_resposta/src/view/shared/custom_texfield.dart';
import 'package:prime_pronta_resposta/src/view/shared/custom_texfield_pwd.dart';
import 'package:prime_pronta_resposta/src/view/auth/cubit/auth_login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocListener<AuthLoginCubit, AuthLoginState>(
          listener: (context, state) {
            if (state is AuthLoginLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (_) => Center(
                      child: LoadingAnimationWidget.halfTriangleDot(
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
              );
            } else if (state is AuthLoginSuccess) {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, AppRouters.homePage);
            } else if (state is AuthLoginFailure) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: const _LoginView(),
        );
      },
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _onLoginPressed() {
    final cubit = context.read<AuthLoginCubit>();
    cubit.login(email: emailController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenSize.height),
          child: Container(
            width: screenSize.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundLogin.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: screenSize.height * .02),
                Container(
                  height: screenSize.height * .2,
                  width: screenSize.width * .4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/prime.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height * .7,
                  decoration: BoxDecoration(
                    color: AppColors.lightColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: TextStyles.instance.primary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            CustomTexfield(
                              labelText: 'Email',
                              hintText: 'Digite seu email',
                              controller: emailController,
                              obscureText: false,
                            ),
                            const SizedBox(height: 20),
                            CustomTexfieldPwd(
                              label: 'Senha',
                              hintText: 'Digite sua senha',
                              backgroundColor: Colors.white,
                              controller: passwordController,
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: _onLoginPressed,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(300, 50),
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  fontFamily: TextStyles.instance.secondary,
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRouters.recoverPage);
                          },
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: TextStyles.instance.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
