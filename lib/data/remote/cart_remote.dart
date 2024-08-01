import '../model/cart_model.dart';
import 'api_path.dart';

class CartRemote {
  Future<List<CartModel>> fetchCart() async {
    try {
      var snapshot = await cartRef.get();
      List<CartModel> carts = snapshot.docs
          .map((e) => CartModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      return carts;
    } catch (e) {
      rethrow;
    }
  }
}
