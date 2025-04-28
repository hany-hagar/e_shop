import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/navigator_methods.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../data/models/category_model.dart';
import '../../../manager/shop_cubit.dart';
import '../../category_view.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items in width
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.93, // Adjust the aspect ratio as needed
      ),
      itemCount: categories.length, // Replace with your actual item count
      itemBuilder: (context, index) {
        return  GestureDetector(
          onTap: () {
            NavigatorMethods.push(context: context, nextPage: CategoryView(tittle: categories[index].name, id:  categories[index].id.toString(),));
            ShopCubit.get(context).searchStart = false;
          },
          child: ExploreViewBodyCustomCategoryItem(model: categories[index],),
        );
      },
    );
  }
}
class ExploreViewBodyCustomCategoryItem extends StatelessWidget {
  final CategoryModel model;
  const ExploreViewBodyCustomCategoryItem({
    super.key, required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      padding: EdgeInsetsDirectional.only(
          top: 4.h, bottom: 2.h, start: 8.w, end: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
            Colors.black26, // Soft black shadow with low opacity
            blurRadius: 8.0, // Moderate blur for a soft shadow
            offset:
            Offset(2.0, 4.0), // Shadow offset to the bottom-right
            spreadRadius: 1.0, // Slight extension of the shadow
          ),
        ],
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 2.h),
            CachedNetworkImage(
              height: 100.h,
              imageUrl: model.image,
              fit: BoxFit.contain,
              errorWidget: (context, error, stackTrace) {
                return const Icon(
                    Icons.error); // Error handling for image loading
              },
            ),
            SizedBox(height: 8.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: double.infinity, // Adjust this value as needed
              ),
              child: Text(
                model.name,
                style: Styles.textStyle700.copyWith(fontSize: 14.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
