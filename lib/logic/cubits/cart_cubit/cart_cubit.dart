import 'dart:async';

import 'package:assignment10/data/models/cart/cart_item_model.dart';
import 'package:assignment10/data/models/product/product_model.dart';
import 'package:assignment10/data/repositories/cart_repository.dart';
import 'package:assignment10/logic/cubits/cart_cubit/cart_state.dart';
import 'package:assignment10/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment10/logic/cubits/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;

  CartCubit(this._userCubit) : super(CartInitialState()) {
    // initial value
    _handleUserState(_userCubit.state);

    // Listening to User cubit(for future update)
    _userSubscription = _userCubit.stream.listen(_handleUserState);
  }

  void _handleUserState(UserState userState) {
    if (userState is UserLoggedInState) {
      _initialize(userState.userModel.sId!);
    } else if (userState is UserLoggedOutState) {
      emit(CartInitialState());
    }
  }

  final _cartRepository = CartRepository();

  void sortAndLoad(List<CartItemModel> items) {
    items.sort(
      (a, b) => b.product!.title!.compareTo(a.product!.title!),
    );
    emit(CartLoadedState(items));
  }

  void _initialize(String userId) async {
    emit(CartLoadingState(state.items));
    try {
      final items = await _cartRepository.fetchCartForUser(userId);
      sortAndLoad(items);
    } catch (error) {
      emit(CartErrorState(error.toString(), state.items));
    }
  }

  void addToCart(ProductModel product, int quantity) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        CartItemModel newItem = CartItemModel(
          product: product,
          quantity: quantity,
        );

        final items =
            await _cartRepository.addToCart(newItem, userState.userModel.sId!);

       sortAndLoad(items);
      } else {
        throw 'An error occured while adding the item!';
      }
    } catch (error) {
      emit(CartErrorState(error.toString(), state.items));
    }
  }

  void removeFromCart(ProductModel product) async {
    emit(CartLoadingState(state.items));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userState = _userCubit.state as UserLoggedInState;

        final items = await _cartRepository.removeFromCart(
            product.sId!, userState.userModel.sId!);

       sortAndLoad(items);
      } else {
        throw 'An error occured while removing the item!';
      }
    } catch (error) {
      emit(CartErrorState(error.toString(), state.items));
    }
  }

  bool cartContains(ProductModel product) {
    if (state.items.isNotEmpty) {
      final foundItem = state.items
          .where((item) => item.product!.sId! == product.sId!)
          .toList();

      if (foundItem.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
