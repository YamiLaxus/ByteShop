import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_target_sa/models/stack_model.dart';
import 'dart:async';

final CollectionReference productCollection =
    Firestore.instance.collection('stack');

class FirebaseServicesStack {
  static final FirebaseServicesStack _instance =
      new FirebaseServicesStack.internal();
  factory FirebaseServicesStack() => _instance;

  FirebaseServicesStack.internal();

  Future<StackModel> createProduct(String text, String image) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot doc = await tx.get(productCollection.document());

      final StackModel images = new StackModel(doc.documentID, text, image);
      final Map<String, dynamic> data = images.toMap();

      await tx.set(doc.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return StackModel.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getProductList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshot = productCollection.snapshots();

    if (offset != null) {
      snapshot = snapshot.skip(offset);
    }

    if (limit != null) {
      snapshot = snapshot.skip(limit);
    }

    return snapshot;
  }
}
