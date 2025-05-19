import 'package:prime_pronta_resposta/src/view/auth/domain/entities/s3_entity.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/domain/repositories/photo_repository.dart';

class UploadPhotoUseCase {
  final PhotoRepository repository;

  UploadPhotoUseCase(this.repository);

  Future<void> call(String base64Image, S3Entity s3) {
    return repository.uploadPhoto(base64Image, s3);
  }
}
