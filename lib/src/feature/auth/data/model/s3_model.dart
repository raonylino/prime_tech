import 'dart:convert';

class S3Model {
  final String accessKeyId;
  final String secretAccessKey;
  final String region;
  final String bucket;
  final String directory;

  S3Model({
    required this.accessKeyId,
    required this.secretAccessKey,
    required this.region,
    required this.bucket,
    required this.directory,
  });

  static String _normalizeBase64(String input) {
    input = input.replaceAll('\n', '').replaceAll(' ', '');
    while (input.length % 4 != 0) {
      input += '=';
    }
    return input;
  }

  factory S3Model.fromBase64Json(Map<String, dynamic> json) => S3Model(
    accessKeyId: utf8.decode(
      base64Decode(_normalizeBase64(json['access_key_id'])),
    ),
    secretAccessKey: utf8.decode(
      base64Decode(_normalizeBase64(json['secret_access_key'])),
    ),
    region: utf8.decode(base64Decode(_normalizeBase64(json['region']))),
    bucket: utf8.decode(base64Decode(_normalizeBase64(json['bucket']))),
    directory: utf8.decode(base64Decode(_normalizeBase64(json['directory']))),
  );

  factory S3Model.fromJson(Map<String, dynamic> json) => S3Model(
    accessKeyId: json['access_key_id'],
    secretAccessKey: json['secret_access_key'],
    region: json['region'],
    bucket: json['bucket'],
    directory: json['directory'],
  );

  Map<String, dynamic> toJson() => {
    'access_key_id': accessKeyId,
    'secret_access_key': secretAccessKey,
    'region': region,
    'bucket': bucket,
    'directory': directory,
  };
}
