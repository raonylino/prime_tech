import 'package:prime_pronta_resposta/src/model/image_profile_model.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? token;
  String? imageProfilePath;
  ImageProfileModel? imageProfile;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.token,
    this.imageProfilePath,
    this.imageProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
      imageProfilePath: json['image_profile_path'],
      imageProfile:
          json['image_profile'] != null
              ? ImageProfileModel.fromJson(json['image_profile'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'image_profile_path': imageProfilePath,
      'image_profile': imageProfile?.toJson(),
    };
  }
}
