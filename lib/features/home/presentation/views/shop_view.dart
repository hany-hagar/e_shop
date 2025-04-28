import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/widgets/loading_view.dart';
import '../manager/shop_cubit.dart';
import 'widgets/ShopViewBodyWidgets/shop_view_body.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if(ShopCubit.get(context).categories.isNotEmpty){
          ShopCubit.get(context).categories.map((toElement)=>ShopCubit.get(context).fetchCategoryProducts(id: toElement.id));
        }
      },
      builder: (context, state) {
        if(ShopCubit.get(context).categories.isNotEmpty){
          return ShopViewBody();
        }
        if ( ShopCubit.get(context).categoriesProducts.isEmpty) {
          return LoadingView();
        }
        else{
          return ShopViewBody();
        }
      },
    );
  }
}
 // HA