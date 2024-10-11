import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class ControllerProfile {
  Future<void> signOut() async {
    log('Sign Out');
    await FirebaseAuth.instance.signOut();
  }
}
