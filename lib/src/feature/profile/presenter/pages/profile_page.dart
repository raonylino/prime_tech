import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_text_styles.dart';
import 'package:prime_pronta_resposta/src/core/dio/injection.dart';
import 'package:prime_pronta_resposta/src/feature/profile/presenter/cubit/profile_cubit.dart';
import 'package:prime_pronta_resposta/src/core/services/geolocator.dart';
import 'package:prime_pronta_resposta/src/widget/custom_profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            Navigator.of(
              context,
            ).pushNamed(AppRouters.errorPage, arguments: state.message);
          }
        },
        builder: (context, state) {
          String name = '';
          String email = '';
          String? image = '';

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
            image = state.imageUrl;
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
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<ProfileCubit>().pickImage();
                        },
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: () {
                              if (state is ProfileImagePicked) {
                                return FileImage(File(image!)) as ImageProvider;
                              } else if (state is ProfileLoaded &&
                                  image != null) {
                                return NetworkImage(image) as ImageProvider;
                              } else {
                                return const AssetImage(
                                  'assets/images/foto_perfil.png',
                                );
                              }
                            }(),
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
                          size: 14,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRouters.profilePageEdit);
                          },
                        ),
                        CustomProfileMenu(
                          label: 'Alterar Senha',
                          icon: Icons.lock,
                          size: 14,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRouters.passwordPage);
                          },
                        ),
                        CustomProfileMenu(
                          label: 'Configurações',
                          icon: Icons.settings,
                          size: 14,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {},
                        ),
                        CustomProfileMenu(
                          label: 'Ajuda',
                          icon: Icons.help,
                          size: 14,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {},
                        ),
                        CustomProfileMenu(
                          label: 'Localização',
                          icon: Icons.location_on,
                          size: 14,
                          backgroundColor: AppColors.primaryColor,
                          onTap: () {
                            ScaffoldMessengerState scaffoldMessenger =
                                ScaffoldMessenger.of(context);
                            getCurrentLocation(scaffoldMessenger);
                          },
                        ),
                        const Spacer(),
                        CustomProfileMenu(
                          label: 'Sair',
                          icon: Icons.logout,
                          size: 14,
                          backgroundColor: AppColors.errorColor,
                          onTap: () {
                            context.read<ProfileCubit>().logout(context);
                          },
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
