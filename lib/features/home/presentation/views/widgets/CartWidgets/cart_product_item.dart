import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/navigator_methods.dart';
import 'package:shop_app/core/utils/styles.dart';
import 'package:shop_app/features/home/data/models/product_model.dart';
import 'package:shop_app/features/home/presentation/manager/shop_cubit.dart';
import 'package:shop_app/features/home/presentation/views/product_view.dart';

class CartProductItem extends StatelessWidget {
  final ProductModel product;
  final Function()? favOnTap;

  const CartProductItem({super.key, required this.product, this.favOnTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            NavigatorMethods.push(
              context: context,
              nextPage: ProductView(product: product),
            );
          },
          child: Container(
            height: 100.h,
            padding: EdgeInsetsDirectional.only(
              top: 8.h,
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
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth:
                              double.infinity, // Adjust this value as needed
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
                          maxWidth:
                              double.infinity, // Adjust this value as needed
                        ),
                        child: Text(
                          product.description,
                          style: Styles.textStyle300.copyWith(fontSize: 12.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 70.w, // Adjust this value as needed
                            ),
                            child: Text(
                              product.price.round().toString(),
                              style: Styles.textStyle700.copyWith(
                                fontSize: 12.sp,
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
                      SizedBox(height: 6,),
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
                                  "Total: ",
                                  style: Styles.textStyle700.copyWith(
                                    fontSize: 12.sp,
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
                                  (product.quantity! * product.price.toInt())
                                      .toString(),
                                  style: Styles.textStyle700.copyWith(
                                    fontSize: 14.sp,
                                    color: Colors.blueAccent,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => ShopCubit.get(context).updateCartProductFunc(
                                  product: product,
                                  newQuantity: (product.quantity! - 1),
                                ),
                                child: Icon(
                                  CupertinoIcons.minus_circled,
                                  size: 30.sp,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                width: 30.w, // Adjust width for better spacing
                                child: Center(
                                  child: Text(
                                    product.quantity.toString(),
                                    style: Styles.textStyle700.copyWith(
                                      fontSize: 14.sp,
                                      color: Colors.blueAccent,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => ShopCubit.get(context).updateCartProductFunc(
                                  product: product,
                                  newQuantity: (product.quantity! + 1),
                                ),
                                child: Icon(
                                  CupertinoIcons.plus_circle,
                                  size: 30.sp,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomProductItemCustomImage extends StatelessWidget {
  const CustomProductItemCustomImage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 16),
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
              return const Icon(
                Icons.error,
              ); // Error handling for image loading
            },
          ),
        ),
      ),
    );
  }
}
