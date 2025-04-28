import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/features/home/presentation/manager/shop_cubit.dart';
import 'package:shop_app/features/home/presentation/views/widgets/FavouriteWidgets/favourite_product_item.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../data/models/product_model.dart';

class FavouriteViewBody extends StatelessWidget {
  final List<ProductModel> products;
  const FavouriteViewBody({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
  builder: (context, state) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 8, bottom: 15.h),
                child: Text(
                  'Favourite Products',
                  style: Styles.textStyle700.copyWith(fontSize: 20.sp),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
              ListView.builder(
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return FavouriteProductItem(product: products[index],favOnTap: () => ShopCubit.get(context).favouriteItemFunc(id: products[index].id),);
                },
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}

