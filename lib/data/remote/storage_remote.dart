import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageRemote {
  final FirebaseStorage _firebaseStorage;

  StorageRemote({FirebaseStorage? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> uploadFile(File file) async {
    final storageRef =
        _firebaseStorage.ref().child('images/${file.path.split('/').last}');
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> deleteFile(String fileUrl) async {
    final storageRef = _firebaseStorage.refFromURL(fileUrl);
    await storageRef.delete();
  }

  Future<String> updateFile(File file, String fileUrl) async {
    await deleteFile(fileUrl);
    return await uploadFile(file);
  }
}
