
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class ControllerRegister {

  static Future<String> registerUsers(String email, String senha) async {

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha,);
      
    } on FirebaseAuthException catch (e) {

      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e,s) {
      log('Erro ao registrar usuário: $e', stackTrace: s);
    }
    return email;
  }

}