import 'package:prime_pronta_resposta/src/feature/dateOperation/domain/entities/data_operation_entity.dart';

class DataOperationModel extends DataOperationEntity {
  DataOperationModel({
    required super.titleOcorrence,
    required super.idService,
    required super.idActionType,
    required super.occourrenceDescription,
    required super.actionDescription,
    required super.latitude,
    required super.longitude,
    required super.dataevidence,
    required super.images,
  });

  factory DataOperationModel.fromJson(Map<String, dynamic> json) {
    return DataOperationModel(
      idService: json['idService'] as String? ?? '',
      idActionType: json['idActionType'] as String? ?? '',
      occourrenceDescription: json['occourrenceDescription'] as String? ?? '',
      actionDescription: json['actionDescription'] as String? ?? '',
      latitude: json['latitude'] as String? ?? '',
      longitude: json['longitude'] as String? ?? '',
      dataevidence: json['dataevidence'] as String? ?? '',
      images: List<String>.from(json['images'] ?? []),
      titleOcorrence: json['titleOcorrence'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identification': titleOcorrence,
      'id_service': idService,
      'id_action_type': idActionType,
      'occurrence_description': occourrenceDescription,
      'action_description': actionDescription,
      'latitude': latitude,
      'longitude': longitude,
      'date_evidence': dataevidence,
      'images': images,
    };
  }
}
