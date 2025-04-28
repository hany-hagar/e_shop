import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/generated/assets.dart';
import '../../../../core/widgets/empty_view.dart';
import '../manager/shop_cubit.dart';
import 'widgets/FavouriteWidgets/favourite_view_body.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopState>(builder: (context, state) {
      if(ShopCubit.get(context).favouritesProducts.isEmpty){
        return EmptyView(tittle: 'Favourite Products',image: Assets.imagesEmptyFavourite,);
      }
      else{
        return FavouriteViewBody(products: ShopCubit.get(context).favouritesProducts,);
      }
    },);

  }
}
