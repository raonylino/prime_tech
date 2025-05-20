
import 'package:prime_pronta_resposta/src/model/contact_model.dart';

class OperationEntity {
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

  OperationEntity({
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
}
