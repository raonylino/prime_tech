// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:prime_pronta_resposta/src/core/dio/app_module.dart' as _i869;
import 'package:prime_pronta_resposta/src/view/auth/data/repositories/auth_repository_impl.dart'
    as _i392;
import 'package:prime_pronta_resposta/src/view/auth/domain/repositories/auth_repository.dart'
    as _i96;
import 'package:prime_pronta_resposta/src/view/auth/domain/usecases/check_login_status_usecase.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/usecases/login_usecase.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/usecases/logout_usecase.dart'
    as _i817;
import 'package:prime_pronta_resposta/src/view/auth/presenter/cubit/auth_login_cubit.dart';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => appModule.storage);
    gh.lazySingleton<_i361.Dio>(() => appModule.dio());
    gh.factory<_i96.AuthRepository>(
      () => _i392.AuthRepositoryImpl(
        gh<_i361.Dio>(),
        gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<CheckLoginStatusUseCase>(
      () => CheckLoginStatusUseCase(gh<_i96.AuthRepository>()),
    );
    gh.factory<LoginUseCase>(() => LoginUseCase(gh<_i96.AuthRepository>()));
    gh.factory<_i817.LogoutUseCase>(() => _i817.LogoutUseCase(gh<_i96.AuthRepository>()));
    gh.factory<AuthLoginCubit>(
      () => AuthLoginCubit(
        loginUseCase: gh<LoginUseCase>(),
        checkLoginStatusUseCase: gh<CheckLoginStatusUseCase>(),
        logoutUseCase: gh<_i817.LogoutUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i869.AppModule {}
