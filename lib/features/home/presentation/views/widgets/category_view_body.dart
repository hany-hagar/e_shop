import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/navigator_methods.dart';
import '../../../../../core/utils/styles.dart';
import '../../../data/models/product_model.dart';
import '../../manager/shop_cubit.dart';
import 'list_of_custom_product_item.dart';

class CategoryViewBody extends StatelessWidget {
  final String tittle;
  final List<ProductModel> products;

  const CategoryViewBody(
      {super.key, required this.tittle, required this.products});

  @override
  Widget build(BuildContext context) {
    String fTittle = tittle[0].toUpperCase() + tittle.substring(1);
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => NavigatorMethods.pop(context: context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 24.sp,
                )),
            centerTitle: true,
            title: Text(
              fTittle.toString(),
              style: Styles.textStyle700.copyWith(fontSize: 20.sp),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          body: BlocBuilder<ShopCubit, ShopState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListOfCustomProductItem(products: products),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
