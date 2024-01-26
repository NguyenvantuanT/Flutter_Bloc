import 'package:flutter/material.dart';
import 'package:lear_bloc/features/home/models/home_product_data_model.dart';
import 'package:lear_bloc/features/wishlist/bloc/wishlist_bloc.dart';

class WishListTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel ;
  final WishlistBloc wishlistBloc ;
  const WishListTileWidget({super.key, required this.productDataModel, required this.wishlistBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productDataModel.imageUrl))
            ),

          ),
          const SizedBox(height: 20),
          Text(productDataModel.name,
          style:const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            ),
          ),
          Text(productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$"+productDataModel.price.toString(),
              style:const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                   IconButton(onPressed: (){
                    // homeBloc.add(HomeProductWishListButtonClickedEvent(
                    //   clickedProduct: productDataModel
                    // ));
                   }, 
                    icon: Icon(Icons.favorite_border)),
                  IconButton(onPressed: (){
                    // cartBloc.add(CartRemoveFromCartEvent(
                    //   productDataModel: productDataModel 
                    // ));
                    wishlistBloc.add(WishlistRemoveFromCartEvent(productDataModel: productDataModel));
                  }, 
                    icon: Icon(Icons.shopping_bag)),
                ],     
              ),
            ],
          ),
          

        ]),
    );
  }
}