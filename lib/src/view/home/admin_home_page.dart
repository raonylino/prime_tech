
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/view/login/controller_login.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

enum PopupMenuPages { product, maintenance }

class _AdminHomePageState extends State<AdminHomePage> {
  bool iconAction = true;
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Administrador',
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
          PopupMenuButton<PopupMenuPages>(
              icon: Icon(
                iconAction ? Icons.menu : Icons.menu_open_outlined,
                color: Colors.white,
              ),
              color: Colors.white,
              popUpAnimationStyle: AnimationStyle(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
              offset: const Offset(2, 50),
              onOpened: () => setState(() => iconAction = !iconAction),
              onCanceled: () => setState(() => iconAction = !iconAction),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: PopupMenuPages.product,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          'Cadastrar Produtos',
                          style: TextStyle(
                            fontFamily: TextStyles.instance.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesAssets.producstRegister);
                    },
                  ),
                  PopupMenuItem(
                    value: PopupMenuPages.maintenance,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text('Cadastrar Manutenção',
                            style: TextStyle(
                              fontFamily: TextStyles.instance.primary,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                ];
              })
        ],
      ),
      body: const Column(
        children: [],
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: AppColors.secondaryColor,
                hoverColor: AppColors.primaryColor,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColors.primaryColor,
                color: AppColors.primaryColor,
                tabs: [
                  GButton(
                    icon: Icons.person,
                    text: 'Perfil',
                    onPressed: () {
                      Navigator.popAndPushNamed(context, RoutesAssets.profilePage);
                    },
                  ),
                  GButton(
                    icon: Icons.home,
                    text: 'Inicio',
                    onPressed: () async{

                      final isadm = await ControllerLogin.isAdm(FirebaseAuth.instance.currentUser!.email!);
                      //  use_build_context_synchronously
                      // ignore: use_build_context_synchronously
                      final currentRoute = ModalRoute.of(context)?.settings.name;
                      if(currentRoute != RoutesAssets.homePage && currentRoute != RoutesAssets.adminHomePage) {
                             // ignore: use_build_context_synchronously
                         Navigator.of(context)
                                  .pushReplacementNamed(isadm
                                      ? RoutesAssets.adminHomePage
                                      : RoutesAssets.homePage);
                      }
                    },
                  ),
                  GButton(
                    icon: Icons.library_books,
                    text: 'Manutenção',
                    onPressed: () {
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
