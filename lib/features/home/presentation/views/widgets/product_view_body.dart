import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/styles.dart';
import 'package:shop_app/core/widgets/custom_button.dart';
import 'package:shop_app/features/home/presentation/views/widgets/list_of_custom_product_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../const/data.dart';
import '../../../../../core/utils/navigator_methods.dart';
import '../../../data/models/product_model.dart';
import '../../manager/shop_cubit.dart';

class ProductViewBody extends StatelessWidget {
  final ProductModel product;

  const ProductViewBody({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);
    var controller = PageController();
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    end: 8,
                    top: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 300.h,
                            child: PageView.builder(
                              controller: controller,
                              itemCount: product.images.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CachedNetworkImage(
                                  imageUrl: product.images[index],
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: controller,
                                count: product.images.length,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: kDefaultColor,
                                  dotColor: Colors.blueGrey,
                                  dotHeight: 10,
                                  dotWidth: 10,
                                  expansionFactor: 4,
                                  spacing: 5,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: GestureDetector(
                              onTap:
                                  () => cubit.favouriteItemFunc(id: product.id),
                              child: Icon(
                                cubit.setFavouriteIcon(product),
                                size: 24.sp,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: GestureDetector(
                              onTap:
                                  () => NavigatorMethods.pop(context: context),
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                size: 24.sp,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        //HomeViewBodyPopularProductsText
                        product.name,
                        style: Styles.textStyle700.copyWith(fontSize: 16.sp),
                        maxLines: 2,
                      ),
                      SizedBox(height: 8),
                      Text(
                        //HomeViewBodyPopularProductsText
                        product.description,
                        style: Styles.textStyle500.copyWith(
                          fontSize: 13.sp,
                          color: Colors.blueGrey[300],
                        ),
                        maxLines: 10,
                      ),
                      SizedBox(height: 16),
                      Text(
                        //HomeViewBodyPopularProductsText
                        'Related Products',
                        style: Styles.textStyle700.copyWith(fontSize: 16.sp),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                ListOfCustomProductItem(products: cubit.homeData.data.products),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            height: 70.h,
            padding: EdgeInsets.all(16),
            elevation: 1,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 70.w, // Adjust this value as needed
                      ),
                      child: Text(
                        "Price : ",
                        style: Styles.textStyle700.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 70.w, // Adjust this value as needed
                      ),
                      child: Text(
                        product.price.round().toString(),
                        style: Styles.textStyle700.copyWith(
                          fontSize: 14.sp,
                          color: Colors.blueAccent,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 70.w, // Adjust this value as needed
                      ),
                      child: Text(
                        '  / ',
                        style: Styles.textStyle500.copyWith(
                          fontSize: 10.sp,
                          color: Colors.blueGrey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 70.w, // Adjust this value as needed
                      ),
                      child: Text(
                        product.oldPrice.round().toString(),
                        style: Styles.textStyle500.copyWith(
                          fontSize: 10.sp,
                          color: Colors.blueGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  width: 130.w,
                  height: 45,
                  onPressed: () => cubit.cartItemStatus(product: product, context: context),
                  text: 'Add to Cart',
                  backGroundColor: Colors.green,
                  isDefault: false,
                  style: Styles.textStyle400.copyWith(fontSize: 13.sp),
                  borderRadius: 32,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
