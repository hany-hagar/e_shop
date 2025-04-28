import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/styles.dart';
import '../../../manager/shop_cubit.dart';
import '../custom_search_bar.dart';

class HomeViewBodyAppBar extends StatelessWidget {
  const HomeViewBodyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/ShopIcon.png',
                    width: 45.w,
                    height: 45.h,
                  ),
                  Text(
                    'E-Shop  ',
                    style: Styles.textStyle700
                        .copyWith(fontSize: 20.sp, color: Theme.of(context).primaryColor),
                  )
                ],
              ),
              Expanded(
                child: CustomSearchBar(
                  onTap: () => ShopCubit.get(context)
                      .changeCurrentIndexOfBottomNavigatorBar(1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () => ShopCubit.get(context)
                      .changeCurrentIndexOfBottomNavigatorBar(2),
                  icon: Icon(
                    Icons.shopping_bag_outlined,
                    size: 25.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 16, end: 16, top: 4, bottom: 0),
            child: Row(
              children: [
                Icon(
                  Icons.delivery_dining_outlined,
                  size: 25.sp,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  '  Deliver To',
                  style: Styles.textStyle500
                      .copyWith(fontSize: 10.sp, color: Theme.of(context).primaryColor),
                ),
                Expanded( // Ensures text does not exceed row width
                  child: Text(
                    '  ${ShopCubit.location.city.city}',
                    style: Styles.textStyle700.copyWith(
                      fontSize: 17.sp,
                      color: Colors.red,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
