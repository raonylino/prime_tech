import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';

 class ControllerLogin {
  static Future<void> loginUser(
      BuildContext context, String email, String password, Function(bool) onSuccess) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {
          log('Login successful');
          onSuccess(true);
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email não verificado! Por favor, verifique seu email.',
                    textAlign: TextAlign.center,
                     style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: TextStyles.instance.secondary,
                    fontWeight: FontWeight.w400,
                  )),
              backgroundColor: Colors.amber[900],
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.code == 'user-not-found'
                ? 'Usuário não encontrado!'
                : e.code == 'wrong-password'
                    ? 'Senha inválida!'
                    : 'Erro ao fazer login. Por favor, tente novamente.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: TextStyles.instance.secondary,
                      fontWeight: FontWeight.w400,
                    ),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );

      log(e.code == 'user-not-found'
          ? 'No user found for that email.'
          : 'Wrong password provided for that user.');
    } catch (e) {
      // Capturar outras exceções
      log('An error occurred: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao fazer login. Por favor, tente novamente.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
