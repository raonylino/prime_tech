import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/view/home/home_page.dart';
import 'package:prime_tech/src/view/login/login_page.dart';
import 'package:prime_tech/src/view/profile/profile_page.dart';
import 'package:prime_tech/src/view/register/register_page.dart';
import 'package:prime_tech/src/view/splash/splash_page.dart';

class PrimeTechApp extends StatelessWidget {

  const PrimeTechApp({ super.key });

   @override
   Widget build(BuildContext context) {
       return MaterialApp(
         routes: { 
           RoutesAssets.splashPage : (context) => const SplashPage(),
           RoutesAssets.loginPage : (context) => const LoginPage(),
           RoutesAssets.registerPage : (context) => const RegisterPage(),
           RoutesAssets.homePage : (context) => const HomePage(),
           RoutesAssets.profilePage : (context) => const ProfilePage(),
         },
       );
  }
}