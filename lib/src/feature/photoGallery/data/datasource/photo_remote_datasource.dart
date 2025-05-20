import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:prime_pronta_resposta/src/core/endpoints/app_endpoints.dart';
import 'package:prime_pronta_resposta/src/feature/auth/domain/entities/s3_entity.dart';
import 'package:prime_pronta_resposta/src/feature/photoGallery/domain/entities/photo_upload_entity.dart';

abstract class PhotoRemoteDatasource {
  Future<void> uploadPhoto(String base64Image, S3Entity s3);
}

class PhotoRemoteDatasourceImpl implements PhotoRemoteDatasource {
  final Dio dio;
  PhotoUploadEntity photoUploadEntity;
  PhotoRemoteDatasourceImpl(this.dio, this.photoUploadEntity);
  @override
  Future<void> uploadPhoto(String base64Image, S3Entity s3) async {
    final imageBytes = utf8.encode(base64Image);
    final fileName = photoUploadEntity.getFileName(imageBytes);

    final url = AppEndpoints.photoUrl(s3: s3);

    final filePath = '$url/service_evidence/$fileName';

    await dio.put(
      filePath,
      data: imageBytes,
      options: Options(headers: {'Content-Type': 'image/jpeg'}),
    );
  }
}
