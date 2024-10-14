import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/model/user_model.dart';

class ControllerRegister {
  static Future<UserModel?> registerUser(BuildContext context,
      String email, String password, String name) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'name': name,
        'isAdmin': false,
      });
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        log('E-mail de verificação enviado para ${user.email}');
      }
      return UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        isAdmin: false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log('E-mail ja existe');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('E-mail ja cadastrado',
                  textAlign: TextAlign.center,
                   style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: TextStyles.instance.secondary,
                  fontWeight: FontWeight.w400,
                ),),
          ),
        );
      }
      log(e.message.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Erro ao cadastrar usuário',
                textAlign: TextAlign.center,
                 style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: TextStyles.instance.secondary,
                fontWeight: FontWeight.w400,
              ),),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
