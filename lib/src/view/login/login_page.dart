import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: 350,
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
                'assets/images/prime.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: screenSize.width * .8,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
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
                decoration: InputDecoration(
                  hintText: 'Senha',
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.1),
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
            SizedBox(
              width: screenSize.width * .8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Esqueceu sua senha?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: TextStyles.instance.secondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Clique aqui',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontFamily: TextStyles.instance.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              width: screenSize.width * .8,
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
                onPressed: () {},
                child: Text(
                  'Entrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: TextStyles.instance.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
                        SizedBox(
              width: screenSize.width * .8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Não possui conta?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: TextStyles.instance.secondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cdastra-se',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontFamily: TextStyles.instance.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
