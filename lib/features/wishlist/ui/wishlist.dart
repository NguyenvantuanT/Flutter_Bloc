
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lear_bloc/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:lear_bloc/features/wishlist/ui/wishlist_tile_wedget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WishList Items'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        
        listener: (context, state) {},
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is !WishlistActionState,
        builder: (context, state) {
          switch(state.runtimeType){
            case WishlistSuccessState : 
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                itemCount: successState.WishlistItems.length,
                itemBuilder: (context, index){
                return WishListTileWidget(
                  wishlistBloc: wishlistBloc,
                  productDataModel: successState.WishlistItems[index], 
                  );
              });
            default:
          }
          return Container();
        },
      ),
    );
  }
}