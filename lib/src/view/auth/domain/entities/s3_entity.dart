class S3Entity {
  final String accessKeyId;
  final String secretAccessKey;
  final String region;
  final String bucket;
  final String directory;

  S3Entity({
    required this.accessKeyId,
    required this.secretAccessKey,
    required this.region,
    required this.bucket,
    required this.directory,
  });
}
