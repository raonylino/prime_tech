import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:prime_pronta_resposta/src/core/endpoints/app_endpoints.dart';
import 'package:prime_pronta_resposta/src/view/auth/data/datasources/auth_remote_datasource.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/repositories/auth_repository.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/usecases/check_login_status_usecase.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/usecases/login_usecase.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/usecases/logout_usecase.dart';
import 'package:prime_pronta_resposta/src/view/auth/presenter/cubit/auth_login_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: AppEndpoints.apiBase)),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<Dio>(), getIt<FlutterSecureStorage>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<Dio>(),
      getIt<FlutterSecureStorage>(),
      getIt<AuthRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<CheckLoginStatusUseCase>(
    () => CheckLoginStatusUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<AuthLoginCubit>(
    () => AuthLoginCubit(
      loginUseCase: getIt<LoginUseCase>(),
      checkLoginStatusUseCase: getIt<CheckLoginStatusUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
    ),
  );
}
