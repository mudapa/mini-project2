import 'package:cloud_firestore/cloud_firestore.dart';

class ApiPath {
  static const String baseUrl = "https://fakestoreapi.com";
}

CollectionReference get userRef =>
    FirebaseFirestore.instance.collection('users');
