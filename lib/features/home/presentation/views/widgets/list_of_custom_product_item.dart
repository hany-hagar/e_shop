import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/navigator_methods.dart';
import '../../../data/models/product_model.dart';
import '../../manager/shop_cubit.dart';
import '../product_view.dart';
import 'custom_product_item.dart';


class ListOfCustomProductItem extends StatelessWidget {
  final List<ProductModel> products;
  const ListOfCustomProductItem({
    super.key, required this.products,
  });

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return GridView.builder(
          addAutomaticKeepAlives: false,
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items in width
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.92, // Adjust the aspect ratio as needed
          ),
          itemCount: products.length,
          // Replace with your actual item count
          itemBuilder: (context, index) {
            return CustomProductItem(
              onTap: () =>NavigatorMethods.push(context: context, nextPage: ProductView(product: products[index])),
              product: products[index], favOnTap: () =>cubit.favouriteItemFunc(id: products[index].id), favIcon: cubit.setFavouriteIcon(products[index]),);
          },
        );
      },
    );
  }
}
