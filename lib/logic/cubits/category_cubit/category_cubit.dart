import 'package:assignment10/data/models/category/category_model.dart';
import 'package:assignment10/data/repositories/category_repository.dart';
import 'package:assignment10/logic/cubits/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState()) {
    _initialize();
  }

  final _categoryRepository = CategoryRepository();

  void _initialize() async {
    emit(CategoryLoadingState(state.categories));

    try {

      List<CategoryModel> categories =
          await _categoryRepository.fetchAllCategories();

      emit(CategoryLoadedState(categories));

    } catch (error) {
      
      emit(CategoryErrorState(state.categories, error.toString()));
    }
  }
}
