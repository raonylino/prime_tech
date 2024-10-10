import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prime_tech/src/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Inicio',
      style: optionStyle,
    ),
    Text(
      'Manutenção',
      style: optionStyle,
    ),
    Text(
      'Perfil',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: screenSize.width,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.normal,
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(6, 6),
                ),
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              image: const DecorationImage(
                image: AssetImage('assets/images/pc_top.jpg'),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            child: Image.asset(
               'assets/images/primeTech.png',
              fit: BoxFit.contain,
            ),
          ),
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
                tabs: const [
                  GButton(
                    icon: Icons.person,
                    text: 'Perfil',
                  ),
                  GButton(
                    icon: Icons.home,
                    text: 'Inicio',
                  ),
                 GButton(
                    icon: Icons.library_books,
                    text: 'Manutenção',
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
