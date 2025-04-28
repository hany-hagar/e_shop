import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/home_model.dart';
import '../../../manager/shop_cubit.dart';
import 'home_view_body_app_bar.dart';
import 'home_view_body_carousel_slider.dart';
import 'home_view_body_categories_text.dart';
import 'home_view_body_list_of_categories_item.dart';
import '../list_of_custom_product_item.dart';
import 'home_view_body_popular_products_text.dart';

class HomeViewBody extends StatelessWidget {
  final HomeModel homeModel;
  final List<CategoryModel> categories;
  const HomeViewBody({super.key, required this.homeModel, required this.categories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeViewBodyAppBar(),
                HomeViewBodyCarouselSlider(banners: homeModel.data.banners,),
                const HomeViewBodyCategoriesText(),
                HomeViewBodyListOfCategoriesItem(categories: categories,),
                HomeViewBodyPopularProductsText(),
                ListOfCustomProductItem(products: homeModel.data.products,),
                SizedBox(height: 16,),
              ],
            ),
          ),
        );
      },
    );
  }
}







