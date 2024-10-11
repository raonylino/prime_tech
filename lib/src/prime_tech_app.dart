import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/view/home/home_page.dart';
import 'package:prime_tech/src/view/login/login_page.dart';
import 'package:prime_tech/src/view/profile/email_profile_page.dart';
import 'package:prime_tech/src/view/profile/name_profile_page.dart';
import 'package:prime_tech/src/view/profile/password_profile_page.dart';
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
           RoutesAssets.profileEmailPage : (context) => const EmailProfilePage(),
           RoutesAssets.profileNamePage : (context) => const NameProfilePage(),
           RoutesAssets.profilePasswordPage : (context) => const PasswordProfilePage(),
         },
       );
  }
}