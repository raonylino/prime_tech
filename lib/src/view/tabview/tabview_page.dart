import 'package:flutter/material.dart';
import 'package:prime_tech/src/view/home/home_page.dart';
import 'package:prime_tech/src/view/profile/profile_page.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class TabviewPage extends StatefulWidget {

  const TabviewPage({ super.key });

  @override
  State<TabviewPage> createState() => _TabviewPageState();
}

class _TabviewPageState extends State<TabviewPage> {
late PageController _pageController;
  int selectedIndex = 1;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
            ),
          ),
        ],
      ),
      bottomNavigationBar:SlidingClippedNavBar(
              backgroundColor: Colors.white,
              onButtonPressed: onButtonPressed,
              iconSize: 30,
              activeColor: const Color(0xFF01579B),
              selectedIndex: selectedIndex,
              barItems: <BarItem>[
                BarItem(
                  icon: Icons.person_rounded,
                  title: 'Perfil',
                ),
                BarItem(
                  icon: Icons.home_rounded,
                  title: 'Home',
                ),
                BarItem(
                  icon: Icons.history_rounded,
                  title: 'Historico',
                ),
              ],
            ),
    );
  }
}

// icon size:24 for fontAwesomeIcons
// icons size: 30 for MaterialIcons

List<Widget> _listOfWidget = <Widget>[
  const ProfilePage(),
  const HomePage(),
  Container(
    alignment: Alignment.center,
    child: const Icon(
      Icons.bolt,
      size: 56,
      color: Colors.brown,
    ),
  ),
];