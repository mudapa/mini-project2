part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends ProductEvent {
  final String title;
  final double price;
  final String description;
  final String category;

  const AddProduct({
    required this.title,
    required this.price,
    required this.description,
    required this.category,
  });

  @override
  List<Object> get props => [
        title,
        price,
        description,
        category,
      ];
}

class FetchListProduct extends ProductEvent {}
