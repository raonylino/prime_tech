import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';

class AdminHomePage extends StatefulWidget {

  const AdminHomePage({ super.key });

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

enum PopupMenuPages {sales,maintenance}

class _AdminHomePageState extends State<AdminHomePage> {

    int _selectedIndex = 1;
   @override
   Widget build(BuildContext context) {
        final screenSize = MediaQuery.of(context).size;
       return Scaffold(
           appBar: AppBar(
            title:  Text('Administrador',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: TextStyles.instance.secondary,
              fontWeight: FontWeight.w400,
            ),
            ),
            backgroundColor: AppColors.primaryColor,
            centerTitle: true,
            actions: [
              PopupMenuButton<PopupMenuPages>(itemBuilder: ( context) {
                return [
                  PopupMenuItem(
                    value: PopupMenuPages.sales,
                    child: const Text('Vendas'),
                    onTap: () {
                      Navigator.pushNamed(context, RoutesAssets.salesRegisterPage);
                    },
                  ),
                  const PopupMenuItem(
                    value: PopupMenuPages.maintenance,
                    child: Text('Manutenção'),
                  ),
                ];
              })
          
            ],
            ),
           body:const Column(
        children: [
        ],
      ),
       bottomNavigationBar: Padding(
         padding: const EdgeInsets.only(bottom: 20.0, right: 8, left: 8),
         child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor:  AppColors.secondaryColor,
                hoverColor: AppColors.primaryColor,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColors.primaryColor,
                color: AppColors.primaryColor,
                tabs:  [
                  GButton(
                    icon: Icons.person,
                    text: 'Perfil',
                    onPressed: (){
                      Navigator.pushNamed(context, RoutesAssets.profilePage);
                    },
                  ),
                  GButton(
                    icon: Icons.home,
                    text: 'Inicio',
                    onPressed: (){
                      Navigator.pushNamed(context, RoutesAssets.homePage);
                    },
                  ),
                 GButton(
                    icon: Icons.library_books,
                    text: 'Manutenção',
                    onPressed: (){
                      Navigator.pushNamed(context, RoutesAssets.splashPage);
                    },
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
               ),
       ),
       );
  }
}