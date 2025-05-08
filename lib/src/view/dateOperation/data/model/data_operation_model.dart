import 'package:prime_pronta_resposta/src/view/dateOperation/domain/entities/data_operation_entity.dart';

class DataOperationModel extends DataOperationEntity {
  DataOperationModel({
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
      idService: json['idService'] as String,
      idActionType: json['idActionType'] as String,
      occourrenceDescription: json['occourrenceDescription'] as String,
      actionDescription: json['actionDescription'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      dataevidence: json['dataevidence'] as String,
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_service': idService,
      'id_action_type': idActionType,
      'occourrence_description': occourrenceDescription,
      'action_description': actionDescription,
      'latitude': latitude,
      'longitude': longitude,
      'data_evidence': dataevidence,
      'images': images,
    };
  }
}
