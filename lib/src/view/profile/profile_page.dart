import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/constants/app_text_styles.dart';
import 'package:prime_pronta_resposta/src/view/profile/cubit/profile_cubit.dart';
import 'package:prime_pronta_resposta/src/view/profile/geolocator.dart';
import 'package:prime_pronta_resposta/src/view/shared/custom_profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ProfileCubit()..loadUserProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          String name = '';
          String email = '';

          if (state is ProfileLoading) {
            return const Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          } else if (state is ProfileLoaded) {
            name = state.name;
            email = state.email;
          } else if (state is ProfileError) {
            return Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: AppColors.primaryColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              backgroundColor: AppColors.primaryColor,
              title: const Text(
                'Perfil',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Column(
                    spacing: 5,
                    children: [
                      const CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(
                            'assets/images/foto_perfil.jpg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: TextStyles.instance.secondary,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: TextStyles.instance.secondary,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: screenSize.width * .9,
                  height: screenSize.height * .5,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CustomProfileMenu(
                          label: 'Editar Perfil',
                          icon: Icons.edit,
                          size: 20,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {},
                        ),
                        CustomProfileMenu(
                          label: 'Configurações',
                          icon: Icons.settings,
                          size: 20,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {},
                        ),
                        CustomProfileMenu(
                          label: 'Ajuda',
                          icon: Icons.help,
                          size: 20,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {},
                        ),
                        CustomProfileMenu(
                          label: 'Localização',
                          icon: Icons.location_on,
                          size: 20,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {
                            getCurrentLocation(context);
                          },
                        ),
                        const Spacer(),
                        CustomProfileMenu(
                          label: 'Sair',
                          icon: Icons.logout,
                          size: 20,
                          backgroundColor: AppColors.errorColor,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
