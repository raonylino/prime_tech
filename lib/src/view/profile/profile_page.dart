import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/view/login/login_page.dart';
import 'package:prime_tech/src/view/profile/controller_profile.dart';
import 'package:prime_tech/src/view/profile/photo_profile_page.dart';
import 'package:prime_tech/src/view/profile/name_profile_page.dart';
import 'package:prime_tech/src/view/profile/password_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUser(); // Chama a função para carregar os dados do usuário
  }

  Future<void> _loadUser() async {
    await ControllerProfile.getUser(); // Chama a função estática
    setState(() {
      userName = ControllerProfile.user?.displayName ?? '';
      userEmail = ControllerProfile.user?.email ?? '';
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: CustomScrollView(
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
                            child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              FirebaseAuth.instance.currentUser?.photoURL ??
                                  'https://via.placeholder.com/150'),
                        ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    userName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: TextStyles.instance.secondary,
                                      fontWeight: FontWeight.w400,
                                    )),
                                Text(
                                  userEmail,
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
                                  builder: (context) => const PhotoProfilePage(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.photo_camera_rounded,
                                        color: AppColors.primaryColor),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Alterar foto de perfil',
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
                            onPressed: () {
                              ControllerProfile.signOut();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                            },
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
                          SizedBox(height: screenSize.height * 0.15),
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
    );
  }
}
