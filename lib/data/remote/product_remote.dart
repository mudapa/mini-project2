import 'dart:convert';

import 'api_path.dart';
import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRemote {
  Future<List<ProductModel>> fetchListProduct() async {
    final response = await http.get(Uri.parse("${ApiPath.baseUrl}/products"));

    if (response.statusCode == 200) {
      List<ProductModel> product = (json.decode(response.body) as List)
          .map((data) => ProductModel.fromJson(data))
          .toList();
      return product;
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<ProductModel> fetchProduct({
    required int id,
  }) async {
    final response =
        await http.get(Uri.parse("${ApiPath.baseUrl}/products/$id"));

    if (response.statusCode == 200) {
      final productCart = ProductModel.fromJson(json.decode(response.body));

      return productCart;
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<List<String>> fetchListCategory() async {
    final response = await http.get(Uri.parse("${ApiPath.baseUrl}/categories"));

    if (response.statusCode == 200) {
      List<String> category = (json.decode(response.body) as List)
          .map((data) => data.toString())
          .toList();
      return category;
    } else {
      throw Exception('Failed to load category');
    }
  }
}
