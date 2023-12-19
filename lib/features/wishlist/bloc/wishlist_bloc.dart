import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_deneme/data/wishlist_items.dart';
import 'package:bloc_deneme/features/home/model/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishListInitialEvent>(wishListInitialEvent);
    on<WishListRemoveFromCartEvent>(wishListRemoveFromCartEvent);
  }

  FutureOr<void> wishListInitialEvent(
      WishListInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItems: wishListItems));
  }

  FutureOr<void> wishListRemoveFromCartEvent(
      WishListRemoveFromCartEvent event, Emitter<WishlistState> emit) {
    wishListItems.remove(event.productDataModel);
    emit(WishlistSuccessState(wishlistItems: wishListItems));
  }
}
