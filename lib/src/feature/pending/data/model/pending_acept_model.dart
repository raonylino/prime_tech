import 'package:prime_pronta_resposta/src/feature/pending/domain/entities/pending_acept_entity.dart';

class PendingAceptModel extends PendingAceptEntity {
  PendingAceptModel({
    required super.id,
    required super.latitude,
    required super.longitude,
    required super.dataTime,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'date_accepted': dataTime,
    };
  }

  factory PendingAceptModel.fromJson(Map<String, dynamic> json) {
    return PendingAceptModel(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      dataTime: json['data_time'],
    );
  }
}
