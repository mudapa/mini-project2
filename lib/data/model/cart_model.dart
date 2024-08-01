class CartModel {
  final String id;
  final String userId;
  final DateTime date;
  final List<ProductCart> products;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        userId: json["userId"],
        date: json["date"].toDate(),
        products: List<ProductCart>.from(
            json["products"].map((x) => ProductCart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductCart {
  final String productId;
  final int quantity;

  ProductCart({
    required this.productId,
    required this.quantity,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) => ProductCart(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}
