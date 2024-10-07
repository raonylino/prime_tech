import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prime_tech/firebase_options.dart';
import 'package:prime_tech/src/prime_tech_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PrimeTechApp());
}