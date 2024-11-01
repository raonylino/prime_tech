
import 'dart:convert';

class ProductModel {

  final String? uid; 
  final String name;
  final String description;
  final int price;
  final String photoUrl;
  final String category;

  ProductModel({
    this.uid,
    required this.name,
    required this.description,
    required this.price,
    required this.photoUrl,
    required this.category
    });

    Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'price': price,
      'photoUrl': photoUrl,
      'category': category
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      photoUrl: map['photoUrl'] ?? '',
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
  
}