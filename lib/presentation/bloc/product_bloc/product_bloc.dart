import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/product_model.dart';
import '../../../data/remote/product_remote.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is AddProduct) {
        emit(ProductLoading());
        try {
          ProductModel product = await ProductRemote().addProduct(
            title: event.title,
            price: event.price,
            description: event.description,
            category: event.category,
          );
          emit(ProductSuccess(product));
        } catch (e) {
          emit(ProductFailure(e.toString()));
        }
      }

      if (event is FetchListProduct) {
        emit(ProductLoading());
        try {
          List<ProductModel> products =
              await ProductRemote().fetchListProduct();
          emit(ProductListSuccess(products));
        } catch (e) {
          emit(ProductFailure(e.toString()));
        }
      }
    });
  }

  Future<ProductModel> getProduct(String productId) async {
    try {
      return await ProductRemote().fetchProduct(productId);
    } catch (e) {
      throw Exception('Failed to fetch product');
    }
  }
}
