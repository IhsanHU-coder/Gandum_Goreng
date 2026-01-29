import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../models/product_model.dart';

class AppService {
  final FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<ProductModel>> streamProducts() {
    return firestore
        .collection('products')
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => ProductModel.fromFirestore(
          doc.id,
          doc.data(),
        ),
      )
          .toList(),
    );
  }

  Future<void> addProduct(ProductModel product) async {
    await firestore
        .collection('products')
        .doc(product.id)
        .set(product.toFirestore(isCreate: true));
  }

  Future<void> updateProduct(ProductModel product) async {
    await firestore
        .collection('products')
        .doc(product.id)
        .update(product.toFirestore());
  }

  Future<void> deleteProduct(String id) async {
    await firestore.collection('products').doc(id).delete();
  }

  Future<String?> uploadProductImage(File image, String productId) async {
    try {
      final ref = FirebaseStorage.instance.ref('products/$productId.jpg');

      await ref.putFile(image);

      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      debugPrint('UPLOAD IMAGE ERROR: ${e.message}');
      return null;
    }
  }

}