import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/view/profile/email_profile_page.dart';
import 'package:prime_tech/src/view/profile/name_profile_page.dart';
import 'package:prime_tech/src/view/profile/password_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
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
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                            child: const Icon(Icons.person, size: 40),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Peterson Andrades',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: TextStyles.instance.secondary,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  'petersonandrades@gmail.com',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14,
                                    fontFamily: TextStyles.instance.secondary,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: screenSize.width * 0.9,
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundColorOpacity,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            'Perfil',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20,
                              fontFamily: TextStyles.instance.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const NameProfilePage(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person,
                                        color: AppColors.primaryColor),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Alterar nome',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily:
                                              TextStyles.instance.secondary,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.chevron_right,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: const Color.fromARGB(131, 158, 158, 158),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                         
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EmailProfilePage(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.email,
                                        color: AppColors.primaryColor),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Alterar e-mail',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily:
                                              TextStyles.instance.secondary,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.chevron_right,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: const Color.fromARGB(131, 158, 158, 158),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                           const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PasswordProfilePage(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.key,
                                        color: AppColors.primaryColor),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Alterar senha',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily:
                                              TextStyles.instance.secondary,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.chevron_right,
                                    color: AppColors.primaryColor),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: const Color.fromARGB(131, 158, 158, 158),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          const SizedBox(height: 15),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.exit_to_app,
                                        color: AppColors.errorColor),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Sair da conta',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontFamily:
                                              TextStyles.instance.secondary,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                const Icon(Icons.chevron_right,
                                    color: AppColors.errorColor),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            color: const Color.fromARGB(131, 158, 158, 158),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          SizedBox(height: screenSize.height * 0.2),
                          Text(
                            ' © 2024. created by: Raony lino',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: TextStyles.instance.secondary,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
                      Navigator.pushNamed(context, RoutesAssets.profilePage);
                    },
                  ),
                  GButton(
                    icon: Icons.home,
                    text: 'Inicio',
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesAssets.homePage);
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
