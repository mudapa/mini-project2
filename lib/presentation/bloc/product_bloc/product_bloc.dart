import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/product_model.dart';
import '../../../data/remote/product_remote.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProductEvent>((event, emit) async {
      emit(ListProductLoading());
      try {
        final listProduct = await ProductRemote().fetchListProduct();
        emit(ListProductSuccess(listProduct));
      } catch (e) {
        emit(ListProductFailure(e.toString()));
      }
    });
  }

  Future<ProductModel> getProduct(int productId) async {
    try {
      return await ProductRemote().fetchProduct(id: productId);
    } catch (e) {
      throw Exception('Failed to fetch product');
    }
  }
}
