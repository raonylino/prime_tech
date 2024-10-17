

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prime_tech/src/model/product_model.dart';

class ProductsRepository {
   final FirebaseFirestore _firestore;

  ProductsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance; 



  final CollectionReference<Map<String, dynamic>> products =
      FirebaseFirestore.instance.collection('produtos');


  Future<void> addProduct(ProductModel product) async {

    final String uid = _firestore.collection('produtos').doc().id;


    final Map<String, dynamic> data = {
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'photoUrl': product.photoUrl,
      'category': product.category,
    };


    await products.doc(uid).set(data);
  }

  Future<void> updateProduct(ProductModel product) async {


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
          uid: snapshot.id,
          name: data!['name'] as String,
          description: data['description'] as String,
          price: data['price'] as int,
          photoUrl: data['photoUrl'] as String,
          category: data['category'] as String);
    } else {
      return null;
    }
  }


  Stream<List<ProductModel>> getAllProducts() {
    return products.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel(
          uid: doc.id,
          name: doc.data()['name'] as String,
          description: doc.data()['description'] as String,
          price: doc.data()['price'] as int,
          photoUrl: doc.data()['photoUrl'] as String,
          category: doc.data()['category'] as String)).toList();
    });
  }

}