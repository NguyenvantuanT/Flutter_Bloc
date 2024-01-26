import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lear_bloc/features/home/bloc/home_bloc.dart';
import 'package:lear_bloc/features/home/ui/product_tile_widget.dart';
import 'package:lear_bloc/features/wishlist/ui/wishlist.dart';

import '../../cart/ui/cart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    homeBloc.add(HomeInitiaLEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is !HomeActionState,
      listener: (context, state) {
        if(state is HomeNavigateToCartPageActionState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
        }else if(state is HomeNavigateToWishListPageActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist()));
        }else if(state is HomeProductItemsWishListedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Items Wishlist')));
        }else if(state is HomeProductItemsCartedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Items Cart')));
        }
       
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState : 
            return  Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadedSuccessState : 
          final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: const Text('BLoC Flutter'),
                actions: [
                  IconButton(onPressed: (){homeBloc.add(HomeWishListButtonNavigateEvent());}, 
                    icon: Icon(Icons.favorite_border)),
                  IconButton(onPressed: (){homeBloc.add(HomeCartButtonNavigateEvent());}, 
                    icon: Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index){
                return ProductTileWidget(
                  homeBloc: homeBloc,
                  productDataModel: successState.products[index]
                );
              }),
            );
          case HomeErrorState: 
            default:
            return SizedBox();
        }
      },
    );
  }
}

