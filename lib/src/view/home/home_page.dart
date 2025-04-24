import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/view/accepted/accepted_page.dart';
import 'package:prime_pronta_resposta/src/view/completed/completed_page.dart';
import 'package:prime_pronta_resposta/src/view/pending/pending_page.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(
      selectedIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Text(
            'Prime Pronta Resposta',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor, // Cor do AppBar

          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRouters.profilePage);
              },
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [PendingPage(), AcceptedPage(), CompletedPage()],
        ),
        bottomNavigationBar: SlidingClippedNavBar(
          backgroundColor: AppColors.primaryColor,
          onButtonPressed: onButtonPressed,
          iconSize: 30,
          activeColor: Colors.white,
          selectedIndex: selectedIndex,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          barItems: [
            BarItem(icon: Icons.car_crash_rounded, title: 'Pendentes'),
            BarItem(icon: Icons.car_repair_rounded, title: 'Aceitos'),
            BarItem(icon: Icons.directions_car_rounded, title: 'Concluidos'),
          ],
        ),
      ),
    );
  }
}
