part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class ListProductLoading extends ProductState {}

class ListProductSuccess extends ProductState {
  final List<ProductModel> products;

  ListProductSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ListProductFailure extends ProductState {
  final String error;

  ListProductFailure(this.error);

  @override
  List<Object> get props => [error];
}
