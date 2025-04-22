import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/view/accepted/accepted_page.dart';
import 'package:prime_pronta_resposta/src/view/auth/cubit/auth_login_cubit.dart';
import 'package:prime_pronta_resposta/src/view/auth/login_page.dart';
import 'package:prime_pronta_resposta/src/view/auth/recover_password_page.dart';
import 'package:prime_pronta_resposta/src/view/dateOperation/date_operation_page.dart';
import 'package:prime_pronta_resposta/src/view/home/home_page.dart';
import 'package:prime_pronta_resposta/src/view/imagePreview/image_preview_page.dart';
import 'package:prime_pronta_resposta/src/view/operation/operation_page.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/photo_gallery_page.dart';
import 'package:prime_pronta_resposta/src/view/profile/profile_page.dart';
import 'package:prime_pronta_resposta/src/view/splash/splash_page.dart';

class PrimeApp extends StatelessWidget {
  const PrimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthLoginCubit(),
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
          AppRouters.operationPage: (context) => const OperationPage(),
          AppRouters.dateOperationPage: (context) => const DateOperationPage(),
          AppRouters.galleryPhotoPage: (context) => const PhotoGalleryPage(),
          AppRouters.recoverPage: (context) => const RecoverPasswordPage(),
          AppRouters.profilePage: (context) => const ProfilePage(),
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
