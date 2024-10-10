import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:validatorless/validatorless.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  final formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
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
                      child: Image.asset(
                        'assets/images/primeTech.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'alterar sua conta',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: TextStyles.instance.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Preencha os campos abaixo para criar sua conta',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: TextStyles.instance.secondary,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        controller: _nameEC,
                        validator: Validatorless.required('Nome obrigatório'),
                        decoration: InputDecoration(
                          hintText: 'Nome',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.person),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        controller: _emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Email obrigatório'),
                          Validatorless.email('Email inválido'),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.email),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha obrigatória'),
                          Validatorless.min(6, 'Mínimo de 6 caracteres'),
                          Validatorless.max(20, 'Máximo de 20 caracteres'),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.key),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Confirme sua senha'),
                          Validatorless.compare(
                              _passwordEC, 'Senhas diferentes'),
                          Validatorless.min(6, 'Mínimo de 6 caracteres'),
                          Validatorless.max(20, 'Máximo de 20 caracteres'),
                        ]),
                        decoration: InputDecoration(
                          hintText: 'Confirme sua senha',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.1),
                          prefixIcon: const Icon(Icons.key),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                        child: SizedBox(
                      height: 20,
                    )),
                    Container(
                      width: screenSize.width * .4,
                      decoration: BoxDecoration(
                        gradient: AppColors.gradient,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () async {},
                        child: Text(
                          'Alterar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                      Navigator.pushNamed(
                          context, RoutesAssets.profilePage);
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
                      Navigator.pushNamed(
                          context, RoutesAssets.splashPage);
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
