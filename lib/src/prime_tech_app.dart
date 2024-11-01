import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/model/product_model.dart';
import 'package:prime_tech/src/repositories/products_repository.dart';
import 'package:prime_tech/src/view/home/admin_home_page.dart';
import 'package:prime_tech/src/view/home/cubit/list_product_cubit.dart';
import 'package:prime_tech/src/view/home/home_page.dart';
import 'package:prime_tech/src/view/login/login_page.dart';
import 'package:prime_tech/src/view/product/register/cubit/register_product_cubit.dart';
import 'package:prime_tech/src/view/product/update/cubit/update_product_cubit.dart';
import 'package:prime_tech/src/view/product/update/update_product_page.dart';
import 'package:prime_tech/src/view/profile/photo_profile_page.dart';
import 'package:prime_tech/src/view/profile/name_profile_page.dart';
import 'package:prime_tech/src/view/profile/password_profile_page.dart';
import 'package:prime_tech/src/view/profile/profile_page.dart';
import 'package:prime_tech/src/view/register/register_page.dart';
import 'package:prime_tech/src/view/product/register/register_product_page.dart';
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
        title: 'Prime Tech',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryColor,
            primary: AppColors.primaryColor,
            secondary: AppColors.secondaryColor,
          ),
        ),
        routes: {
          //--------------- SPLASH ---------------
          RoutesAssets.splashPage: (context) => const SplashPage(),

          //--------------- LOGIN ---------------
          RoutesAssets.loginPage: (context) => const LoginPage(),

          //--------------- REGISTER ---------------
          RoutesAssets.registerPage: (context) => const RegisterPage(),
          RoutesAssets.profilePage: (context) => const ProfilePage(),
          RoutesAssets.profilePhotoPage: (context) => const PhotoProfilePage(),
          RoutesAssets.profileNamePage: (context) => const NameProfilePage(),
          RoutesAssets.profilePasswordPage: (context) =>
              const PasswordProfilePage(),

          //--------------- HOME ---------------
          RoutesAssets.adminHomePage: (context) {
            return BlocProvider(
              create: (context) => ListProductCubit(
                repository: context.read<ProductsRepository>(),
              )..findAllProducts(),
              child: const AdminHomePage(),
            );
          },
          RoutesAssets.homePage: (context) {
            return BlocProvider(
              create: (context) => ListProductCubit(
                repository: context.read<ProductsRepository>(),
              )..findAllProducts(),
              child: const HomePage(),
            );
          },

          //--------------- PRODUCT ---------------
          RoutesAssets.productsRegister: (context) => BlocProvider(
                create: (context) => RegisterProductCubit(
                  repository: context.read<ProductsRepository>(),
                ),
                child: const RegisterProductPage(),
              ),
          RoutesAssets.productsEdit: (context){
            final productCubit = ModalRoute.of(context)!.settings.arguments as ProductModel;
            return BlocProvider(
                create: (context) => UpdateProductCubit(
                  repository: context.read<ProductsRepository>(),
                ),
                child: UpdateProductPage(
                  product: productCubit,
                ),
              );
          },
          //--------------- TABVIEW ---------------
          RoutesAssets.tabView: (context) => BlocProvider(
                create: (context) => ListProductCubit(
                  repository: context.read<ProductsRepository>(),
                )..findAllProducts(),
                child: const TabviewPage(),
              ),
          RoutesAssets.admTabView: (context) => BlocProvider(
                create: (context) => ListProductCubit(
                  repository: context.read<ProductsRepository>(),
                )..findAllProducts(),
                child: const AdmTabviewPage(),
              ),
        },
      ),
    );
  }
}
