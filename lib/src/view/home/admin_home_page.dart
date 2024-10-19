
import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

enum PopupMenuPages { product, maintenance }

class _AdminHomePageState extends State<AdminHomePage> {
  bool iconAction = true;

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
    );
  }
}
