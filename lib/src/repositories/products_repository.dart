import 'dart:io';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:prime_tech/src/model/product_model.dart';

class ProductsRepository {
  final FirebaseFirestore _firestore;

  ProductsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> products =
      FirebaseFirestore.instance.collection('produtos');

  Future<void> addProduct(ProductModel product) async {
    try {
      final String uid = _firestore.collection('produtos').doc().id;

      final Reference storageReference =
          FirebaseStorage.instance.ref().child('produtos/$uid');
      final UploadTask uploadTask =
          storageReference.putFile(File(product.photoUrl));
      final TaskSnapshot downloadUrl = await uploadTask;
      final String imageUrl = await downloadUrl.ref.getDownloadURL();

      final Map<String, dynamic> data = {
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'photoUrl': imageUrl,
        'category': product.category,
      };

      await FirebaseFirestore.instance
          .collection('produtos')
          .doc(uid)
          .set(data);
      log('Produto adicionado com sucesso!');
    } catch (e) {
      log('Erro ao adicionar produto: $e');
    }
  }

Future<void> updateProduct(ProductModel product) async {
  if (product.uid == null || product.uid!.isEmpty) {
   log('Erro ao atualizar o produto: ID do produto vazio ${product.uid}');
  }

  final String uid = product.uid!;

  final Map<String, dynamic> data = {
    'name': product.name,
    'description': product.description,
    'price': product.price,
    'photoUrl': product.photoUrl,
    'category': product.category,
  };

  await products.doc(uid).update(data);
}

  Future<void> deleteProduct(String uid) async {
    await products.doc(uid).delete();
  }

  Future<ProductModel?> getProduct(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await products.doc(uid).get();

    if (snapshot.exists) {
      final data = snapshot.data();
      return ProductModel(
          uid: data!['uid'] as String,
          name: data['name'] as String,
          description: data['description'] as String,
          price: data['price'] as int,
          photoUrl: data['photoUrl'] as String,
          category: data['category'] as String);
    } else {
      return null;
    }
  }

  Future<List<ProductModel>> getAllProducts() {
    log('carregando produtos');	
    final product = _firestore.collection('produtos').get();
    return product.then((querySnapshot) =>
        querySnapshot.docs.map((e) => ProductModel.fromMap(e.data())).toList());
  }
}
