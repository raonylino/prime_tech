import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:prime_pronta_resposta/src/core/endpoints/app_endpoints.dart';
import 'package:prime_pronta_resposta/src/view/auth/domain/entities/s3_entity.dart';
import 'package:prime_pronta_resposta/src/view/photoGallery/domain/entities/photo_upload_entity.dart';

abstract class PhotoRemoteDatasource {
  Future<void> uploadPhoto(String base64Image, S3Entity s3);
}

class PhotoRemoteDatasourceImpl implements PhotoRemoteDatasource {
  final Dio dio;
  late PhotoUploadEntity photoUploadEntity;
  PhotoRemoteDatasourceImpl(this.dio);
  @override
  Future<void> uploadPhoto(String base64Image, S3Entity s3) async {
    final imageBytes = base64Decode(base64Image);
    final fileName = photoUploadEntity.getFileName(imageBytes);

    final url = AppEndpoints.photoUrl(s3: s3);

    final filePath = '$url/$fileName';

    await dio.put(
      filePath,
      data: imageBytes,
      options: Options(headers: {'Content-Type': 'image/jpeg'}),
    );
  }
}
