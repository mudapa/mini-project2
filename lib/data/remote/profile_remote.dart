import 'package:cloud_firestore/cloud_firestore.dart';

import '../../routes/routes.dart';
import '../model/user_model.dart';
import 'api_path.dart';

class ProfileRemote {
  Future<UserModel> getUserById(String id) async {
    try {
      await settings.put('id', id);

      DocumentSnapshot userDoc = await userRef.doc(id).get();

      UserModel user = UserModel.fromJson(
          userDoc.id, userDoc.data() as Map<String, dynamic>);

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
