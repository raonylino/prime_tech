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
import 'package:prime_pronta_resposta/src/view/dateOperation/data/datasources/data_operation_remoto_datasource.dart';
import 'package:prime_pronta_resposta/src/view/dateOperation/domain/repositories/data_operation_repository.dart';
import 'package:prime_pronta_resposta/src/view/dateOperation/domain/usecases/data_opereation_usecase.dart';
import 'package:prime_pronta_resposta/src/view/dateOperation/presenter/cubit/data_operation_cubit.dart';
import 'package:prime_pronta_resposta/src/view/operation/data/datasources/operation_remote_datasouces.dart';
import 'package:prime_pronta_resposta/src/view/operation/domain/repositories/operation_repository.dart';
import 'package:prime_pronta_resposta/src/view/operation/domain/usecases/fetch_operation_by_id_usecase.dart';
import 'package:prime_pronta_resposta/src/view/operation/presenter/cubit/operation_cubit.dart';
import 'package:prime_pronta_resposta/src/view/pending/data/datasources/pending_datasource.dart';
import 'package:prime_pronta_resposta/src/view/pending/domain/repositories/pending_repository.dart';
import 'package:prime_pronta_resposta/src/view/pending/domain/usecases/pending_usecase.dart';
import 'package:prime_pronta_resposta/src/view/pending/presenter/cubit/pending_cubit.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/data/datasource/photo_remote_datasource.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/domain/repositories/photo_repository.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/domain/usecases/upload_photo_usecase.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/presenter/cubit/photo_gallery_cubit.dart';
import 'package:prime_pronta_resposta/src/view/profile/data/datasource/profile_datasource.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/repositories/profile_repository.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/usecases/change_password.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/usecases/get_user_profile.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/usecases/update_user_profile.dart';
import 'package:prime_pronta_resposta/src/view/profile/domain/usecases/upload_profile_image.dart';
import 'package:prime_pronta_resposta/src/view/profile/presenter/cubit/profile_cubit.dart';

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
  getIt.registerLazySingleton<PendingRemoteDataSource>(
    () => PendingRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<PendingRepository>(
    () => PendingRepositoryImpl(
      getIt<PendingRemoteDataSource>(),
      getIt<FlutterSecureStorage>(),
    ),
  );

  getIt.registerFactory<PendingUsecase>(
    () => PendingUsecase(getIt<PendingRepository>()),
  );

  getIt.registerFactory<PendingCubit>(
    () => PendingCubit(getIt<PendingUsecase>()),
  );

  getIt.registerLazySingleton<OperationRemoteDataSource>(
    () => OperationRemoteDataSourceImpl(
      getIt<Dio>(),
      getIt<FlutterSecureStorage>(),
    ),
  );

  getIt.registerLazySingleton<OperationRepository>(
    () => OperationRepositoryImpl(getIt<OperationRemoteDataSource>()),
  );

  getIt.registerFactory<FetchOperationByIdUseCase>(
    () => FetchOperationByIdUseCase(getIt<OperationRepository>()),
  );

  getIt.registerFactory<OperationCubit>(
    () => OperationCubit(getIt<FetchOperationByIdUseCase>()),
  );

  getIt.registerLazySingleton<DataOperationRemoteDataSource>(
    () => DataOperationRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerLazySingleton<DataOperationRepository>(
    () => DataOperationRepositoryImpl(
      getIt<DataOperationRemoteDataSource>(),
      getIt<FlutterSecureStorage>(),
    ),
  );
  getIt.registerFactory<DataOpereationUsecase>(
    () => DataOpereationUsecase(getIt<DataOperationRepository>()),
  );
  getIt.registerFactory<DataOperationCubit>(
    () => DataOperationCubit(getIt<DataOpereationUsecase>()),
  );

  // DataSource
  getIt.registerLazySingleton<ProfileDataSource>(
    () => ProfileDataSourceImpl(getIt<Dio>()),
  );

  // Repository
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileDataSource>()),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetUserProfile(getIt<ProfileRepository>()));
  getIt.registerLazySingleton(
    () => UpdateUserProfile(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton(
    () => UploadProfileImage(getIt<ProfileRepository>()),
  );
  getIt.registerLazySingleton(() => ChangePassword(getIt<ProfileRepository>()));

  // Cubit
  getIt.registerFactory(
    () => ProfileCubit(
      getUserProfileUseCase: getIt(),
      updateUserProfileUseCase: getIt(),
      uploadProfileImageUseCase: getIt(),
      changePasswordUseCase: getIt(),
    ),
  );

  // Photo Gallery Dependencies
  getIt.registerLazySingleton<PhotoRemoteDatasource>(
    () => PhotoRemoteDatasourceImpl(
      getIt<Dio>()
      ),
  );
  getIt.registerLazySingleton<PhotoRepository>(
    () => PhotoRepositoryImpl(getIt<PhotoRemoteDatasource>()),
  );
  getIt.registerLazySingleton<UploadPhotoUseCase>(
    () => UploadPhotoUseCase(getIt<PhotoRepository>()),
  );
  getIt.registerFactory<PhotoGalleryCubit>(
    () => PhotoGalleryCubit(
      uploadPhotoUseCase: getIt<UploadPhotoUseCase>(),
      storage: getIt<FlutterSecureStorage>(),
    ),
  );
}
