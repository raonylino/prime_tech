import 'package:prime_pronta_resposta/src/view/auth/domain/entities/s3_entity.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/data/datasource/photo_remote_datasource.dart';

abstract class PhotoRepository {
  Future<void> uploadPhoto(String base64Image, S3Entity s3);
}

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDatasource photoRemoteDatasource;
  PhotoRepositoryImpl(this.photoRemoteDatasource);
  @override
  Future<void> uploadPhoto(String base64Image, S3Entity s3) async {
    await photoRemoteDatasource.uploadPhoto(base64Image, s3);
  }
}
