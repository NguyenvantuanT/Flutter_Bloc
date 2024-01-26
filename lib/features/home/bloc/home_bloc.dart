import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lear_bloc/data/cart_items.dart';
import 'package:lear_bloc/data/grocey_data.dart';
import 'package:lear_bloc/data/wishlist_items.dart';
import 'package:lear_bloc/features/home/models/home_product_data_model.dart';
import 'package:lear_bloc/features/wishlist/ui/wishlist.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitiaLEvent>(homeInitiaLEvent);

    on<HomeProductWishListButtonClickedEvent>
      (homeProductWishListButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>
      (homeProductCartButtonClickedEven);

    on<HomeWishListButtonNavigateEvent>
      (homeWishListButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>
      (homeCartButtonNavigateEvent);
  }

  FutureOr<void> homeInitiaLEvent(
    HomeInitiaLEvent event, Emitter<HomeState> emit) async{
      emit(HomeLoadingState());
      await Future.delayed(Duration(seconds: 3));
      emit(
        HomeLoadedSuccessState(
        products: GroceyData.groceryProducts.map((e) => ProductDataModel(
            id: e['id'], 
            name: e['name'], 
            description: e['description'], 
            price: e['price'], 
            imageUrl: e['imageUrl']
            )).toList()
            )
     );
  }

  FutureOr<void> homeProductWishListButtonClickedEvent(
    HomeProductWishListButtonClickedEvent event, Emitter<HomeState> emit) {
      print('Wishlist Product List');
      WishlistItems.add(event.clickedProduct);
      emit(HomeProductItemsWishListedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEven(
    HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
      print('Cart Product List');
      cartItems.add(event.clickedProduct);
      emit(HomeProductItemsCartedActionState());
  }

  FutureOr<void> homeWishListButtonNavigateEvent(
    HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
      print('Wishlist Navigate List');
      emit(HomeNavigateToWishListPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
    HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
      print('Cart Navigate List');
      emit(HomeNavigateToCartPageActionState());
  }

  
}
