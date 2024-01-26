import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lear_bloc/data/wishlist_items.dart';
import 'package:lear_bloc/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromCartEvent>(wishlistRemoveFromCartEvent);
  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(WishlistItems: WishlistItems));
  }

  FutureOr<void> wishlistRemoveFromCartEvent(WishlistRemoveFromCartEvent event, Emitter<WishlistState> emit) {
    WishlistItems.remove(event.productDataModel);
    emit(WishlistSuccessState(WishlistItems: WishlistItems));
  }
}
