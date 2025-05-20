import 'package:prime_pronta_resposta/src/feature/pending/domain/entities/pending_entity.dart';

class PendingModel extends PendingEntity {
  PendingModel({
    required super.title,
    required super.companyName,
    required super.id,
  });

  factory PendingModel.fromJson(Map<String, dynamic> json) {
    return PendingModel(
      title: json['identification'],
      companyName: json['shipping_company_name'],
      id: json['id'],
    );
  }
}
