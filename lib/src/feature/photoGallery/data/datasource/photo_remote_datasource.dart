import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prime_pronta_resposta/src/core/endpoints/app_endpoints.dart';
import 'package:prime_pronta_resposta/src/core/enums/aws_regions_enum.dart';
import 'package:prime_pronta_resposta/src/feature/auth/domain/entities/s3_entity.dart';
import 'package:prime_pronta_resposta/src/feature/photoGallery/domain/entities/photo_upload_entity.dart';
import 'package:simple_s3/simple_s3.dart';

abstract class PhotoRemoteDatasource {
  Future<void> uploadPhoto(String base64Image, S3Entity s3);
}

class PhotoRemoteDatasourceImpl implements PhotoRemoteDatasource {
  final Dio dio;
  PhotoUploadEntity photoUploadEntity;
  PhotoRemoteDatasourceImpl(this.dio, this.photoUploadEntity);

  @override
  Future<void> uploadPhoto(String base64Image, S3Entity s3) async {
    final SimpleS3 simpleS3 = SimpleS3();

    final imageBytes = utf8.encode(base64Image);
    final fileName = photoUploadEntity.getFileName(imageBytes);

    final url = AppEndpoints.photoUrl(s3: s3);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.jpg');
    await file.writeAsBytes(imageBytes);
    final filePath = '$url/service_evidence';

    await simpleS3.uploadFile(
      file,
      s3.bucket,
      'us-east-1:936d86b4-f2e7-4072-a2f4-80c91ec77bba',
      AWSRegions.usEast1,
      fileName: fileName,
      s3FolderPath: filePath,
      useTimeStamp: false,
    );
  }
}
