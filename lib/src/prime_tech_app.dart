import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/view/splash/splash_page.dart';

class PrimeTechApp extends StatelessWidget {

  const PrimeTechApp({ super.key });

   @override
   Widget build(BuildContext context) {
       return MaterialApp(
         routes: { 
           RoutesAssets.splashPage : (context) => const SplashPage(),
         },
       );
  }
}