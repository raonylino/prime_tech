// ignore_for_file: public_member_api_docs, sort_constructors_first

class DataOperationEntity {
  final String idService;
  final String idActionType;
  final String occourrenceDescription;
  final String actionDescription;
  final String latitude;
  final String longitude;
  final String dataevidence;
  final List<String> images;

  DataOperationEntity({
    required this.idService,
    required this.idActionType,
    required this.occourrenceDescription,
    required this.actionDescription,
    required this.latitude,
    required this.longitude,
    required this.dataevidence,
    required this.images,
  });
}
