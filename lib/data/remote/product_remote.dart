import '../model/product_model.dart';
import 'api_path.dart';

class ProductRemote {
  Future<ProductModel> addProduct({
    required String title,
    required double price,
    required String description,
    required String category,
  }) async {
    try {
      var productId = productRef.doc().id;

      ProductModel product = ProductModel(
        id: productId,
        title: title,
        price: price.toDouble(),
        description: description,
        category: category,
        image: "https://placehold.jp/200x200.png",
        rating: Rating(
          rate: 0,
          count: 0,
        ),
      );

      productRef.doc(productId).set({
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
        'rating': product.rating?.toJson(),
      });

      return product;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> fetchProduct(String id) async {
    try {
      var snapshot = await productRef.doc(id).get();
      ProductModel product = ProductModel.fromJson(
        snapshot.data() as Map<String, dynamic>,
      );

      return product;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchListProduct() async {
    try {
      var snapshot = await productRef.get();
      List<ProductModel> products = snapshot.docs
          .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }
}
