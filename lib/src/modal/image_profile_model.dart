class ImageProfileModel {
  final int id;
  final int? idCompany;
  final int idUser;
  final String type;
  final String image;
  final int userCreate;
  final int? userUpdate;
  final DateTime createdAt;
  final DateTime updatedAt;

  ImageProfileModel({
    required this.id,
    this.idCompany,
    required this.idUser,
    required this.type,
    required this.image,
    required this.userCreate,
    this.userUpdate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ImageProfileModel.fromJson(Map<String, dynamic> json) {
    return ImageProfileModel(
      id: json['id'],
      idCompany: json['id_company'],
      idUser: json['id_user'],
      type: json['type'],
      image: json['image'],
      userCreate: json['user_create'],
      userUpdate: json['user_update'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_company': idCompany,
      'id_user': idUser,
      'type': type,
      'image': image,
      'user_create': userCreate,
      'user_update': userUpdate,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
