
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prime_tech/src/model/user_model.dart';

class ControllerRegister {
  static Future<UserModel?> registerUser(String email, String password, String name) async {
    try {

      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,

      });

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);

      return UserModel(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        isAdmin: false,
      );
    } on FirebaseAuthException catch (e) {

      log(e.message.toString());
    } catch (e) {

      log(e.toString());
    }
    return null;
  }
}