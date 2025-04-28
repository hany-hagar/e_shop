import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/styles.dart';
import '../../../../data/models/category_model.dart';

class HomeViewBodyCategoriesItem extends StatelessWidget {
  final CategoryModel model;
  const HomeViewBodyCategoriesItem({
    super.key, required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      margin: EdgeInsetsDirectional.only(start: 16,bottom: 8,top: 8),
      padding: EdgeInsetsDirectional.only(top: 4.h, bottom: 2.h, start: 8.w, end: 8.w),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(64.r),
          topLeft: Radius.circular(64.r),
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
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
        children: [
          Container(
            width: 70.w,
            height: 65.h,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl:model.image,
              fit: BoxFit.fill,
              errorWidget: (context, error, stackTrace) {
                return const Icon(
                    Icons.error); // Error handling for image loading
              },
            ),
          ),
          SizedBox(height: 3.h),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 70.w, // Adjust this value as needed
            ),
            child: Text(
              model.name,
              style: Styles.textStyle700.copyWith(fontSize: 12.sp,height: 1.2,color: Theme.of(context).primaryColor),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}