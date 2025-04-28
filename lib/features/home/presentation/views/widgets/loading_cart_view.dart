import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/styles.dart';

class LoadingCartView extends StatelessWidget {
  const LoadingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Cart Product',
              style: Styles.textStyle700.copyWith(fontSize: 20.sp),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: CircularProgressIndicator(
                    color: CupertinoColors.systemGreen,),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
