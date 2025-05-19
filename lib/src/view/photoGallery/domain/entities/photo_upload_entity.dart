import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class PhotoUploadEntity {
  final String userId;
  final String serviceId;
  final String extension;
  PhotoUploadEntity({
    required this.userId,
    required this.serviceId,
    this.extension = 'jpg',
  });

  String getFileName(Uint8List imageBytes) {
    final hash = md5.convert(imageBytes).toString();
    return '${userId}_${serviceId}_$hash.$extension';
  }
}
