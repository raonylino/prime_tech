import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prime_pronta_resposta/src/core/dio/injection.dart';
import 'package:prime_pronta_resposta/src/feature/prime_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await dotenv.load();
  runApp(const PrimeApp());
}
