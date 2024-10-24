import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/repositories/products_repository.dart';
import 'package:prime_tech/src/view/home/admin_home_page.dart';
import 'package:prime_tech/src/view/home/cubit/list_product_cubit.dart';
import 'package:prime_tech/src/view/home/home_page.dart';
import 'package:prime_tech/src/view/login/login_page.dart';
import 'package:prime_tech/src/view/product/Cubit/register_product_cubit.dart';
import 'package:prime_tech/src/view/profile/photo_profile_page.dart';
import 'package:prime_tech/src/view/profile/name_profile_page.dart';
import 'package:prime_tech/src/view/profile/password_profile_page.dart';
import 'package:prime_tech/src/view/profile/profile_page.dart';
import 'package:prime_tech/src/view/register/register_page.dart';
import 'package:prime_tech/src/view/product/register_product_page.dart';
import 'package:prime_tech/src/view/splash/splash_page.dart';
import 'package:prime_tech/src/view/tabview/adm_tabview_page.dart';
import 'package:prime_tech/src/view/tabview/tabview_page.dart';

class PrimeTechApp extends StatelessWidget {
  const PrimeTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductsRepository(),
      child: MaterialApp(
        routes: {
          RoutesAssets.adminHomePage: (context) {
            return BlocProvider(
              create: (context) => ListProductCubit(
                repository: context.read(),
              )..findAllProducts(),
              child: const AdminHomePage(),
            );
          },
          RoutesAssets.splashPage: (context) => const SplashPage(),
          RoutesAssets.loginPage: (context) => const LoginPage(),
          RoutesAssets.registerPage: (context) => const RegisterPage(),
          RoutesAssets.profilePage: (context) => const ProfilePage(),
          RoutesAssets.profilePhotoPage: (context) => const PhotoProfilePage(),
          RoutesAssets.profileNamePage: (context) => const NameProfilePage(),
          RoutesAssets.profilePasswordPage: (context) =>
              const PasswordProfilePage(),
          RoutesAssets.producstRegister: (context) => BlocProvider(
                create: (context) =>
                    RegisterProductCubit(repository: context.read()),
                child: const RegisterProductPage(),
              ),
          RoutesAssets.homePage: (context) => const HomePage(),
          RoutesAssets.tabView: (context) => const TabviewPage(),
          RoutesAssets.admTabView: (context) => const AdmTabviewPage(),
        },
      ),
    );
  }
}
