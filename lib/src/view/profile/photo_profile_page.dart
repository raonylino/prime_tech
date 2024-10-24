import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/view/profile/controller_profile.dart';

class PhotoProfilePage extends StatefulWidget {
  const PhotoProfilePage({super.key});

  @override
  State<PhotoProfilePage> createState() => _PhotoProfilePageState();
}

class _PhotoProfilePageState extends State<PhotoProfilePage> {
  File? _image;
  bool isLoading = false;

  Future<void> _changeProfilePicture() async {
    // Pega a imagem escolhida
    File? pickedImage = await ControllerProfile.pickImage();

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });

      // Faz o upload da imagem e pega a URL do Firebase Storage
      String? photoUrl = await ControllerProfile.uploadImage(_image!);

      if (photoUrl != null) {
        // Atualiza a foto de perfil no Firebase Auth
        await ControllerProfile.updateProfilePicture(photoUrl);

        setState(() {
          isLoading = true;
        });

        Future.delayed(const Duration(seconds: 5), () {
          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Perfil atualizado com sucesso!'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Foto de perfil atualizada com sucesso!')),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao fazer upload da imagem.')),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhuma imagem selecionada.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                    child: Image.asset(
                      'assets/images/primeTech.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Altere sua foto de perfil',
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
                    'escolha uma imagem de perfil',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: TextStyles.instance.secondary,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.normal,
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: const Offset(10, 10),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: _image != null
                            ? CircleAvatar(
                                radius: 100,
                                backgroundImage: FileImage(_image!),
                              )
                            : CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(FirebaseAuth
                                        .instance.currentUser?.photoURL ??
                                    'https://via.placeholder.com/150'),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Expanded(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: screenSize.width * .4,
                        decoration: BoxDecoration(
                          gradient: AppColors.gradientGrey,
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
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Voltar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                          ),
                        ),
                      ),
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
                          onPressed: _changeProfilePicture,
                          child: Text(
                            isLoading ? 'Salvando' : 'Alterar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                          ),
                        ),
                      ),
                    ],
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
    );
  }
}
