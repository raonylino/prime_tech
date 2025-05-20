import 'package:prime_pronta_resposta/src/feature/auth/data/model/s3_model.dart';
import 'package:prime_pronta_resposta/src/feature/auth/domain/entities/s3_entity.dart';

extension S3ModelMapper on S3Model {
  S3Entity toEntity() {
    return S3Entity(
      accessKeyId: accessKeyId,
      secretAccessKey: secretAccessKey,
      region: region,
      bucket: bucket,
      directory: directory,
    );
  }
}
