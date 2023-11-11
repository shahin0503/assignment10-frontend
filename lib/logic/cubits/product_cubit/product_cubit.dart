import 'package:assignment10/data/models/product/product_model.dart';
import 'package:assignment10/data/repositories/product_repository.dart';
import 'package:assignment10/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final _productRepository = ProductRepository();

  void _initialize() async {
    emit(ProductLoadingState(state.products));

    try {

      List<ProductModel> products =
          await _productRepository.fetchAllProducts();

      emit(ProductLoadedState(products));

    } catch (error) {
      
      emit(ProductErrorState(state.products, error.toString()));
    }
  }
}
