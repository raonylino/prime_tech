import 'dart:typed_data';

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
    final hash = imageBytes.hashCode.toString();
    return '${userId}_${serviceId}_$hash.$extension';
  }
}
