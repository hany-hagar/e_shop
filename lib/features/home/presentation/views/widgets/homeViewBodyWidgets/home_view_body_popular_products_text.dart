import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/styles.dart';

class HomeViewBodyPopularProductsText extends StatelessWidget {
  const HomeViewBodyPopularProductsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 14.w, horizontal: 16.h,),
      child: Text(
        //HomeViewBodyPopularProductsText
        'Popular Products',
        style: Styles.textStyle700.copyWith(fontSize: 16.sp,color: Theme.of(context).primaryColor),
      ),
    );
  }
}
