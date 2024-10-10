
import 'dart:convert';

class UserModel {

  final String? uid; 
  final String name;
  final String email;
  final bool isAdmin;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    this.isAdmin = false
    });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : '',
      email: map['email'] != null ? map['email'] as String : '',
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as bool : false,
    );
  }

   String toJson() => json.encode(toMap());

   factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

}