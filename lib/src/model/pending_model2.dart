import 'package:prime_pronta_resposta/src/model/contact_model.dart';

class PendingModel2 {
  final int id;
  final int idCompany;
  final int? idClient;
  final int sequence;
  final int idServiceType;
  final int idServiceStatus;
  final String identification;
  final int idOccurrenceType;
  final List<String> goods;
  final String shippingCompanyName;
  final String cep;
  final String address;
  final String number;
  final String complement;
  final String neighborhood;
  final String city;
  final String uf;
  final String referencePoint;
  final String latitude;
  final String longitude;
  final List<Contact> contacts;
  final String observation;
  final int idUserCreate;
  final int? idUserUpdate;
  final String createdAt;
  final String updatedAt;

  PendingModel2({
    required this.id,
    required this.idCompany,
    this.idClient,
    required this.sequence,
    required this.idServiceType,
    required this.idServiceStatus,
    required this.identification,
    required this.idOccurrenceType,
    required this.goods,
    required this.shippingCompanyName,
    required this.cep,
    required this.address,
    required this.number,
    required this.complement,
    required this.neighborhood,
    required this.city,
    required this.uf,
    required this.referencePoint,
    required this.latitude,
    required this.longitude,
    required this.contacts,
    required this.observation,
    required this.idUserCreate,
    this.idUserUpdate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PendingModel2.fromJson(Map<String, dynamic> json) {
    return PendingModel2(
      id: json['id'],
      idCompany: json['id_company'],
      idClient: json['id_client'],
      sequence: json['sequence'],
      idServiceType: json['id_service_type'],
      idServiceStatus: json['id_service_status'],
      identification: json['identification'],
      idOccurrenceType: json['id_occurrence_type'],
      goods: List<String>.from(json['goods']),
      shippingCompanyName: json['shipping_company_name'],
      cep: json['cep'],
      address: json['address'],
      number: json['number'],
      complement: json['complement'],
      neighborhood: json['neighborhood'],
      city: json['city'],
      uf: json['uf'],
      referencePoint: json['reference_point'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      contacts:
          (json['contacts'] as List).map((c) => Contact.fromJson(c)).toList(),
      observation: json['observation'],
      idUserCreate: json['id_user_create'],
      idUserUpdate: json['id_user_update'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
