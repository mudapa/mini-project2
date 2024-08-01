import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference get userRef =>
    FirebaseFirestore.instance.collection('users');

CollectionReference get productRef =>
    FirebaseFirestore.instance.collection('products');

CollectionReference get cartRef =>
    FirebaseFirestore.instance.collection('carts');
