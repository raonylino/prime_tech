import 'package:prime_pronta_resposta/src/feature/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.imageProfilePath,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    imageProfilePath: json['image_profile_path'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'phone': phone,
    'image_profile_path': imageProfilePath,
  };
}
