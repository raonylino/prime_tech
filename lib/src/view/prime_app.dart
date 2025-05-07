import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/core/dio/injection.dart';
import 'package:prime_pronta_resposta/src/model/pending_model2.dart';
import 'package:prime_pronta_resposta/src/view/accepted/accepted_page.dart';
import 'package:prime_pronta_resposta/src/view/auth/presenter/cubit/auth_login_cubit.dart';
import 'package:prime_pronta_resposta/src/view/auth/presenter/pages/login_page.dart';
import 'package:prime_pronta_resposta/src/view/auth/presenter/pages/recover_password_page.dart';
import 'package:prime_pronta_resposta/src/view/dateOperation/date_operation_page.dart';
import 'package:prime_pronta_resposta/src/view/error/error_page.dart';
import 'package:prime_pronta_resposta/src/view/home/home_page.dart';
import 'package:prime_pronta_resposta/src/view/imagePreview/image_preview_page.dart';
import 'package:prime_pronta_resposta/src/view/operation/operation_page.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/photo_gallery_page.dart';
import 'package:prime_pronta_resposta/src/view/profile/profile_edit_page.dart';
import 'package:prime_pronta_resposta/src/view/profile/profile_page.dart';
import 'package:prime_pronta_resposta/src/view/profile/profile_password_page.dart';
import 'package:prime_pronta_resposta/src/view/splash/splash_page.dart';

class PrimeApp extends StatelessWidget {
  const PrimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthLoginCubit>(create: (_) => getIt<AuthLoginCubit>()),
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
          AppRouters.operationPage: (context) {
            final pending =
                ModalRoute.of(context)!.settings.arguments as PendingModel2;
            return OperationPage(pending: pending);
          },
          AppRouters.dateOperationPage: (context) => const DateOperationPage(),
          AppRouters.galleryPhotoPage: (context) => const PhotoGalleryPage(),
          AppRouters.recoverPage: (context) => const RecoverPasswordPage(),
          AppRouters.profilePage: (context) => const ProfilePage(),
          AppRouters.errorPage: (context) => const ErrorPage(),
          AppRouters.profilePageEdit: (context) => const ProfileEditPage(),
          AppRouters.passwordPage: (context) => const ProfilePasswordPage(),
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
