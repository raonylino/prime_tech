import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/core/constants/app_text_styles.dart';
import 'package:prime_pronta_resposta/src/feature/photoGallery/presenter/cubit/photo_gallery_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PhotoGalleryPage extends StatelessWidget {
  const PhotoGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galeria de Fotos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontFamily: TextStyles.instance.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).popAndPushNamed(AppRouters.dateOperationPage);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: BlocListener<PhotoGalleryCubit, PhotoGalleryState>(
                listener: (context, state) {
                  if (state is PhotoGallerySuccess) {
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.success(
                        message: 'Foto enviada com sucesso!',
                      ),
                    );
                  }
                  if (state is PhotoGalleryError) {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(message: state.message),
                    );
                  }
                },
                child: BlocBuilder<PhotoGalleryCubit, PhotoGalleryState>(
                  builder: (context, state) {
                    if (state is PhotoGalleryUploading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PhotoGallerySuccess) {
                      final imageFiles = state.imageFiles;
                      if (imageFiles.isEmpty) {
                        return const Center(
                          child: Text('Nenhuma foto enviada.'),
                        );
                      }
                      return GridView.builder(
                        itemCount: imageFiles.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouters.imagePreviewPage,
                                arguments: imageFiles[index],
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  imageFiles[index],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is PhotoGalleryInitial) {
                      return const Center(child: Text('Nenhuma foto enviada.'));
                    } else {
                      return const Center(
                        child: Text('Erro ao carregar galeria.'),
                      );
                    }
                  },
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                context.read<PhotoGalleryCubit>().pickAndUploadImage();
              },
              icon: const Icon(Icons.camera_alt_outlined),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                minimumSize: Size(screenSize.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              label: const Text('Tirar foto'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
