import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:prime_pronta_resposta/src/view/auth/data/model/s3_model.dart';
import 'package:prime_pronta_resposta/src/view/auth/data/model/s3_model_mapper.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/domain/usecases/upload_photo_usecase.dart';

part 'photo_gallery_state.dart';

class PhotoGalleryCubit extends Cubit<PhotoGalleryState> {
  final UploadPhotoUseCase uploadPhotoUseCase;
  final FlutterSecureStorage storage;

  PhotoGalleryCubit({required this.uploadPhotoUseCase, required this.storage})
    : super(PhotoGalleryInitial());

  final List<File> _images = [];

  Future<void> pickAndUploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image == null) {
        emit(PhotoGalleryError('Imagem não selecionada.'));
        return;
      }

      emit(PhotoGalleryUploading());

      final File imageFile   = File(image.path);
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final s3Json = await storage.read(key: 's3_access');
      if (s3Json == null) {
        emit(PhotoGalleryError('Credenciais do S3 não encontradas.'));
        return;
      }

      final s3Map = jsonDecode(s3Json);
      final s3Model = S3Model.fromJson(s3Map);
      final s3Entity = s3Model.toEntity();

      await uploadPhotoUseCase(base64Image, s3Entity);

      emit(PhotoGallerySuccess(_images));
    } catch (e) {
      emit(PhotoGalleryError('Erro ao enviar imagem: ${e.toString()}'));
    }
  }


}
