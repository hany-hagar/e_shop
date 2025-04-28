import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/features/home/presentation/manager/shop_cubit.dart';
import 'package:shop_app/features/home/presentation/views/widgets/CartWidgets/cart_product_item.dart';

import '../../../../../../core/utils/styles.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ShopCubit cubit = ShopCubit.get(context);
    final cartProducts = cubit.cartData.first.data?.products ?? [];

    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cart Products',
                  style: Styles.textStyle700.copyWith(fontSize: 20.sp),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16,),
                cartProducts.isNotEmpty ?
                ListView.builder(
                  addAutomaticKeepAlives: false,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartProducts.length,
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];
                    return CartProductItem(product: product);
                  },
                )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
