import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static final FirestoreHelper firestoreHelper = FirestoreHelper._();
  Firestore firestore = Firestore.instance;
  addNewProduct(String productName, String imageurl) async {
    firestore
        .collection('products')
        .add({'productName': productName, 'image': imageurl});
  }

  addNewUser() async {}
  addNewOrder() async {}
}
