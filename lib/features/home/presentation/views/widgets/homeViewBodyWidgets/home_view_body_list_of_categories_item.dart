import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/navigator_methods.dart';
import '../../../../data/models/category_model.dart';
import '../../../manager/shop_cubit.dart';
import '../../category_view.dart';
import 'home_view_body_categories_item.dart';

class HomeViewBodyListOfCategoriesItem extends StatelessWidget {
  final List<CategoryModel> categories;
  const HomeViewBodyListOfCategoriesItem({
    super.key, required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(onTap:() {
          log("list id : ${categories[index].id}");
          ShopCubit.get(context).fetchCategoryProducts(id: categories[index].id);
          NavigatorMethods.push(context: context, nextPage: CategoryView(tittle: categories[index].name.toUpperCase() + categories[index].name.substring(1), id: categories[index].id.toString(),));
        },child: HomeViewBodyCategoriesItem(model: categories[index],)),
      ),
    );
  }
}
