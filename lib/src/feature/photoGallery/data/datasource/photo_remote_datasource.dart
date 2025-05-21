import 'dart:convert';
import 'dart:io';
import 'package:aws_s3_upload_lite/aws_s3_upload_lite.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
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
    final imageBytes = base64Decode(base64Image);
    final fileName = photoUploadEntity.getFileName(imageBytes);

    // Cria arquivo temporário
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName.jpg');
    await file.writeAsBytes(imageBytes);

    try {
      await AwsS3.uploadFile(
        accessKey: s3.accessKeyId,
        secretKey: s3.secretAccessKey,
        region: s3.region,
        bucket: s3.bucket,
        file: file,
        filename: fileName, // Add this line
        destDir: s3.directory, // exemplo: 'service_evidence'
      );
    } catch (e) {
      print('Erro ao fazer upload: $e');
      throw Exception('Erro no upload: $e');
    }
  }
}
