import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_path.dart';
import '../model/cart_model.dart';

class CartRemote {
  Future<List<CartModel>> fetchCart() async {
    final response = await http.get(Uri.parse("${ApiPath.baseUrl}/carts"));

    if (response.statusCode == 200) {
      List<CartModel> cart = (json.decode(response.body) as List)
          .map((data) => CartModel.fromJson(data))
          .toList();
      return cart;
    } else {
      throw Exception('Failed to load cart');
    }
  }
}
