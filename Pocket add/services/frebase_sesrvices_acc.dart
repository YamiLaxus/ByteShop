import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_target_sa/models/acc_model.dart';
import 'dart:async';

final CollectionReference productCollection =
    Firestore.instance.collection('acc');

class FirebaseServices {
  static final FirebaseServices _instance = new FirebaseServices.internal();
  factory FirebaseServices() => _instance;

  FirebaseServices.internal();

  Future<AccModel> createProduct(String name, String image, String type,
      String details, int price, int quantity) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot doc = await tx.get(productCollection.document());

      final AccModel acc = new AccModel(
          doc.documentID, name, image, details, type, price, quantity);
      final Map<String, dynamic> data = acc.toMap();

      await tx.set(doc.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return AccModel.fromMap(mapData);
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
