import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/navigator_methods.dart';
import 'package:shop_app/core/utils/styles.dart';
import 'package:shop_app/features/home/data/models/product_model.dart';
import 'package:shop_app/features/home/presentation/manager/shop_cubit.dart';
import 'package:shop_app/features/home/presentation/views/product_view.dart';

class FavouriteProductItem extends StatelessWidget {
  final ProductModel product;
  final Function()? favOnTap;

  const FavouriteProductItem({super.key, required this.product, this.favOnTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorMethods.push(
          context: context,
          nextPage: ProductView(product: product),
        );
      },
      child: Container(
        height: 108.h,
        padding: EdgeInsetsDirectional.only(
          top: 11.h,
          bottom: 2.h,
          start: 2.w,
          end: 8.w,
        ),
        margin: EdgeInsetsDirectional.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black26, // Soft black shadow with low opacity
              blurRadius: 8.0, // Moderate blur for a soft shadow
              offset: Offset(2.0, 4.0), // Shadow offset to the bottom-right
              spreadRadius: 1.0, // Slight extension of the shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomProductItemCustomImage(product: product),
            SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: double.infinity, // Adjust this value as needed
                    ),
                    child: Text(
                      product.name,
                      style: Styles.textStyle700.copyWith(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: double.infinity, // Adjust this value as needed
                    ),
                    child: Text(
                      product.description,
                      style: Styles.textStyle300.copyWith(fontSize: 12.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
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
                      GestureDetector(
                        onTap: favOnTap,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsetsDirectional.only(end: 10.0),
                          child: Icon(
                            ShopCubit.get(
                              context,
                            ).favouritesProducts.contains(product)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 22.sp,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProductItemCustomImage extends StatelessWidget {
  const CustomProductItemCustomImage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsetsDirectional.only(start: 16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 80.h, // Adjust this value as needed
          maxWidth: 80.h, // Adjust this value as needed
        ),
        child: Center(
          child: CachedNetworkImage(
            height: 100.h,
            width: 100.h,
            imageUrl: product.image,
            fit: BoxFit.contain,
            errorWidget: (context, error, stackTrace) {
              return const Icon(Icons.error); // Error handling for image loading
            },
          ),
        ),
      ),
    );
  }
}
