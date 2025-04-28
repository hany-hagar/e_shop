import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/home/presentation/views/widgets/loading_cart_view.dart';
import 'package:shop_app/generated/assets.dart';
import '../../../../core/widgets/empty_view.dart';
import '../manager/shop_cubit.dart';
import 'widgets/CartWidgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        if (state is FetchCartDataLoading) {
          return const LoadingCartView();
        } else {
          final cubit = context.watch<ShopCubit>();
          final products = cubit.cartData.first.data?.products;

          if (products == null || products.isEmpty) {
            return const EmptyView(
              tittle: 'Cart Products',
              image: Assets.imagesEmptyIcon,
            );
          } else {
            return const CartViewBody();
          }
        }
      },
    );
  }
}
