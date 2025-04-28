import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_view.dart';
import '../manager/shop_cubit.dart';
import 'widgets/category_view_body.dart';

class CategoryView extends StatelessWidget {
  final String tittle;
  final String id;
  const CategoryView({super.key, required this.tittle, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        // Get the product list safely
        final products = ShopCubit.get(context).categoriesProducts[id];
        if (products == null || products.isEmpty) {
          return const LoadingView(); // Show loading when null or empty
        } else {
          return CategoryViewBody(
            tittle: tittle,
            products: products,
          );
        }
      },
    );
  }
}
