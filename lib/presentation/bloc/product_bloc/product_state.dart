part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final ProductModel product;

  ProductSuccess(this.product);

  @override
  List<Object> get props => [product];
}

final class ProductListSuccess extends ProductState {
  final List<ProductModel> products;

  ProductListSuccess(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductFailure extends ProductState {
  final String message;

  ProductFailure(this.message);

  @override
  List<Object> get props => [message];
}
