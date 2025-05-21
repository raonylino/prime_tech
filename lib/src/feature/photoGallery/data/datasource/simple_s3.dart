import 'package:prime_pronta_resposta/src/core/enums/aws_regions_enum.dart';

extension AwsRegionStringExtension on String {
  AwsRegion parseRegion() {
    switch (this) {
      case 'us-east-1':
        return AwsRegion.usEast1;
      case 'us-west-1':
        return AwsRegion.usWest1;
      case 'eu-west-1':
        return AwsRegion.euWest1;
      case 'sa-east-1':
        return AwsRegion.saEast1;
      default:
        throw ArgumentError('Região não suportada');
    }
  }
}
