import 'package:prime_pronta_resposta/src/feature/accepted/domain/entities/accepted_entity.dart';

class AcceptedModel extends AcceptedEntity {
  AcceptedModel({
    required super.title,
    required super.companyName,
    required super.id,
  });

  factory AcceptedModel.fromJson(Map<String, dynamic> json) {
    return AcceptedModel(
      title: json['identification'],
      companyName: json['shipping_company_name'],
      id: json['id'],
    );
  }
}
