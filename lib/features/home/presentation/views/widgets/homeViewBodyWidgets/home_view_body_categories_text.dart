import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/styles.dart';

class HomeViewBodyCategoriesText extends StatelessWidget {
  const HomeViewBodyCategoriesText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:16,right:16,top:8, bottom: 4),
      child: Text(
        'Categories',
        style: Styles.textStyle700.copyWith(fontSize: 16.sp,color: Theme.of(context).primaryColor),
      ),
    );
  }
}
