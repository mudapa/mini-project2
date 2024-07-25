import 'package:cloud_firestore/cloud_firestore.dart';

import '../../routes/routes.dart';
import '../model/user_model.dart';
import 'api_path.dart';

class UserRemote {
  Future<UserModel> signUp({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      var userId = userRef.doc().id;

      UserModel user = UserModel(
        id: userId,
        email: email,
        userName: userName,
        password: password,
        role: 1,
      );

      userRef.doc(userId).set({
        'id': user.id,
        'email': user.email,
        'userName': user.userName,
        'password': user.password,
        'role': user.role,
      });

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String userName,
    required String password,
  }) async {
    try {
      QuerySnapshot users = await userRef
          .where('userName', isEqualTo: userName)
          .where('password', isEqualTo: password)
          .get();

      if (users.docs.isEmpty) {
        throw 'Username or password is incorrect';
      }

      await settings.put('id', users.docs[0].id);

      return UserModel.fromJson(
          users.docs[0].id, users.docs[0].data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await settings.delete('id');
    } catch (e) {
      rethrow;
    }
  }
}
