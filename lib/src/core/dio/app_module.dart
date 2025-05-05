import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:prime_pronta_resposta/src/core/endpoints/app_endpoints.dart';

@module
abstract class AppModule {
  @lazySingleton
  Dio dio() => Dio(
    BaseOptions(
      baseUrl: AppEndpoints.apiBase,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  @lazySingleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();
}
