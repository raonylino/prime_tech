import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/core/dio/injection.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/data/model/accepted_model.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/presenter/accepted_page.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/presenter/cubit/accepted_cubit.dart';
import 'package:prime_pronta_resposta/src/feature/auth/presenter/cubit/auth_login_cubit.dart';
import 'package:prime_pronta_resposta/src/feature/auth/presenter/pages/login_page.dart';
import 'package:prime_pronta_resposta/src/feature/auth/presenter/pages/recover_password_page.dart';
import 'package:prime_pronta_resposta/src/feature/dateOperation/domain/usecases/data_opereation_usecase.dart';
import 'package:prime_pronta_resposta/src/feature/dateOperation/presenter/cubit/data_operation_cubit.dart';
import 'package:prime_pronta_resposta/src/feature/dateOperation/presenter/date_operation_page.dart';
import 'package:prime_pronta_resposta/src/feature/error/error_page.dart';
import 'package:prime_pronta_resposta/src/feature/home/home_page.dart';
import 'package:prime_pronta_resposta/src/feature/photoGallery/presenter/cubit/photo_gallery_cubit.dart';
import 'package:prime_pronta_resposta/src/feature/photoGallery/presenter/pages/image_preview_page.dart';
import 'package:prime_pronta_resposta/src/feature/operation/domain/usecases/fetch_operation_by_id_usecase.dart';
import 'package:prime_pronta_resposta/src/feature/operation/presenter/cubit/operation_cubit.dart';
import 'package:prime_pronta_resposta/src/feature/operation/presenter/operation_page.dart';
import 'package:prime_pronta_resposta/src/feature/pending/data/model/pending_model.dart';
import 'package:prime_pronta_resposta/src/feature/pending/domain/usecases/pending_usecase.dart';
import 'package:prime_pronta_resposta/src/feature/pending/presenter/cubit/pending_cubit.dart';
import 'package:prime_pronta_resposta/src/feature/photoGallery/presenter/pages/photo_gallery_page.dart';
import 'package:prime_pronta_resposta/src/feature/profile/presenter/cubit/profile_cubit.dart';
import 'package:prime_pronta_resposta/src/feature/profile/presenter/pages/profile_edit_page.dart';
import 'package:prime_pronta_resposta/src/feature/profile/presenter/pages/profile_page.dart';
import 'package:prime_pronta_resposta/src/feature/profile/presenter/pages/profile_password_page.dart';
import 'package:prime_pronta_resposta/src/feature/splash/splash_page.dart';

class PrimeApp extends StatelessWidget {
  const PrimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthLoginCubit>(create: (_) => getIt<AuthLoginCubit>()),
        BlocProvider<PendingCubit>(
          create: (_) => PendingCubit(getIt<PendingUsecase>()),
        ),
        BlocProvider<OperationCubit>(
          create: (_) => OperationCubit(getIt<FetchOperationByIdUseCase>()),
        ),
        BlocProvider<DataOperationCubit>(
          create: (_) => DataOperationCubit(getIt<DataOpereationUsecase>()),
        ),
        BlocProvider<ProfileCubit>(create: (_) => getIt<ProfileCubit>()),

        BlocProvider<PhotoGalleryCubit>(
          create: (_) => getIt<PhotoGalleryCubit>(),
        ),

        BlocProvider<AcceptedCubit>(create: (_) => getIt<AcceptedCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prime App',
        theme: ThemeData(primarySwatch: Colors.blueGrey, useMaterial3: true),
        initialRoute: AppRouters.splashPage,
        routes: {
          AppRouters.homePage: (context) => const HomePage(),
          AppRouters.splashPage: (context) => const SplashPage(),
          AppRouters.loginPage: (context) => const LoginPage(),
          AppRouters.acceptedPage: (context) => const AcceptedPage(),
          AppRouters.dateOperationPage: (context) => const DateOperationPage(),
          AppRouters.galleryPhotoPage: (context) => const PhotoGalleryPage(),
          AppRouters.recoverPage: (context) => const RecoverPasswordPage(),
          AppRouters.profilePage: (context) => const ProfilePage(),
          AppRouters.errorPage: (context) => const ErrorPage(),
          AppRouters.profilePageEdit: (context) => const ProfileEditPage(),
          AppRouters.passwordPage: (context) => const ProfilePasswordPage(),
          AppRouters.operationPage: (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Object;

            if (args is PendingModel) {
              return OperationPage(pending: args);
            } else if (args is AcceptedModel) {
              return OperationPage(accepted: args);
            } else {
              return const Scaffold(
                body: Center(child: Text('Erro: tipo inválido')),
              );
            }
          },
        },
        onGenerateRoute: (settings) {
          if (settings.name == AppRouters.imagePreviewPage) {
            final file = settings.arguments as File;
            return MaterialPageRoute(
              builder: (_) => ImagePreviewPage(imageFile: file),
            );
          }
          return null;
        },
      ),
    );
  }
}
