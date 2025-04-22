import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? token;

  UserModel({this.id, this.name, this.email, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
  }
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      token: map['token'],
    );
  }
}
