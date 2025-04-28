import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/styles.dart';
import '../../../data/models/product_model.dart';
import '../../manager/shop_cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';


class CustomProductItem extends StatelessWidget {
  final ProductModel product;
  final  Function()? favOnTap;
  final Function()? onTap;

  final IconData favIcon;
  const CustomProductItem({
    super.key,
    required this.product,
    required this.favOnTap,
    required this.favIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            height: 400.h,
            padding: EdgeInsetsDirectional.only(
                top: 4.h, bottom: 0, start: 8.w, end: 8.w),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomProductItemCustomImage(product: product),
                SizedBox(height: 4.h),
                CustomProductItemCustomTittle(product: product),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // لجعل الأيقونة تبدأ من الأعلى
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomProductItemCustomDescription(product: product),
                          SizedBox(height: 1.9.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center, // لضبط محاذاة النص والأيقونة
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 70.w),
                                      child: Text(
                                        " ",
                                        style: Styles.textStyle700.copyWith(fontSize: 12.sp, color: Colors.blueAccent),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 70.w),
                                      child: Text(
                                        product.price.round().toString(),
                                        style: Styles.textStyle700.copyWith(fontSize: 12.sp, color: Colors.blueAccent),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 70.w),
                                      child: Text(
                                        '  / ',
                                        style: Styles.textStyle500.copyWith(fontSize: 10.sp, color: Colors.blueGrey),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 70.w),
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
                              ),
                              // Container(
                              //   decoration: BoxDecoration(
                              //     color: Colors.white12,
                              //     borderRadius: BorderRadius.circular(24),
                              //   ),
                              //   padding: const EdgeInsets.all(10.0),
                              //   child: Icon(
                              //     Icons.shield_moon_outlined,
                              //     size: 20.sp,
                              //     color: Colors.green,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // SizedBox(height: 4.h),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: GestureDetector(
              onTap: favOnTap,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(24)),
                margin: EdgeInsetsDirectional.only(top: 8,end: 8),
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  ShopCubit.get(context).favouritesProducts.contains(product) ?Icons.favorite:Icons.favorite_border,
                  size: 20.sp,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => ShopCubit.get(context).cartItemStatus(product: product, context: context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(24), topStart: Radius.circular(8)),
              ),
              padding: const EdgeInsets.all(14.0),
              child: Icon(
                CupertinoIcons.plus,
                size: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomProductItemCustomDescription extends StatelessWidget {
  const CustomProductItemCustomDescription({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final text = product.description;
    final words = text.split(' ');

    // Ensure there are at least three words in the description
    if (words.length < 3) {
      return AutoSizeText(
        text,
        style: Styles.textStyle300.copyWith(fontSize: 12.sp,color: Theme.of(context).primaryColor),
        maxLines: 1,
        minFontSize: 10, // Ensures text is always visible
        overflow: TextOverflow.ellipsis,
      );
    }

    // First line should contain exactly 3 words
    final firstLine = words.take(3).join(' ');
    // Second line should contain the remaining words
    final secondLine = words.skip(3).join(' ');

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// First line with exactly 3 words, text fits dynamically
          AutoSizeText(
            firstLine,
            style: Styles.textStyle300.copyWith(fontSize: 12.sp,color: Theme.of(context).primaryColor),
            maxLines: 1,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              /// Second line containing the remaining words, text fits dynamically
              Expanded(
                child: AutoSizeText(
                  secondLine,
                  style: Styles.textStyle300.copyWith(fontSize: 12.sp,color: Theme.of(context).primaryColor),
                  maxLines: 1,
                  minFontSize: 10,
                  overflow: TextOverflow.fade,
                ),
              ),
              SizedBox(width: 35.w),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomProductItemCustomTittle extends StatelessWidget {
  const CustomProductItemCustomTittle({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: double.infinity, // Adjust this value as needed
      ),
      child: Text(
        product.name,
        style: Styles.textStyle700.copyWith(fontSize: 12.sp,color: Theme.of(context).primaryColor),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

class CustomProductItemCustomImage extends StatelessWidget {
  const CustomProductItemCustomImage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 80.h, // Adjust this value as needed
      ),
      child: Center(
        child: CachedNetworkImage(
          height: 100.h,
          imageUrl: product.image,
          fit: BoxFit.contain,
          errorWidget: (context, error, stackTrace) {
            return const Icon(
                Icons.error); // Error handling for image loading
          },
        ),
      ),
    );
  }
}
