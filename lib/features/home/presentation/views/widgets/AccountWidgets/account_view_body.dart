import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/navigator_methods.dart';
import 'package:shop_app/features/home/presentation/manager/shop_cubit.dart';
import 'package:shop_app/features/home/presentation/views/widgets/AccountWidgets/about_view.dart';
import 'package:shop_app/features/home/presentation/views/widgets/AccountWidgets/help_view.dart';
import 'package:shop_app/features/home/presentation/views/widgets/AccountWidgets/notification_view.dart';
import 'package:shop_app/features/home/presentation/views/widgets/AccountWidgets/payment_methods_view.dart';
import 'package:shop_app/features/home/presentation/views/widgets/AccountWidgets/personal_view.dart';
import 'package:shop_app/features/home/presentation/views/widgets/AccountWidgets/promo_code_view.dart';
import 'package:shop_app/features/home/presentation/views/widgets/AccountWidgets/settings_view.dart';
import '../../../../../../core/utils/styles.dart';
import 'delivery_address_view.dart';

class AccountViewBody extends StatelessWidget {
  const AccountViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    var user = cubit.loginModel.data;

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => NavigatorMethods.push(context: context, nextPage: PersonalView(title: "Personal Settings",),),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.h,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: user.image ,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, error, stackTrace) => Image.network('https://scontent.fcai19-7.fna.fbcdn.net/v/t39.30808-6/473089256_1795702557841991_2045160077905892668_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeHDS1H7r9JqDf8Y3reCHnMp3HUs7sE__SbcdSzuwT_9JsM0775MfBnAFJNYwB_nleZRPoWgQ_vTE5WH6C9ZAEQE&_nc_ohc=E8sNgEP_pMgQ7kNvgHyvmYr&_nc_oc=Adhw80Fc9GTWpOLWS5tHCVup4HvxuCeirGC00pf7sjQ8U30k3fdhWawuVcNO78seWfM&_nc_zt=23&_nc_ht=scontent.fcai19-7.fna&_nc_gid=APLJSZJZddXEJjhl5yudEG7&oh=00_AYGywgzwA9_hPZmo4boPTma2M-82_cYCWgA1XtWX0i_gEg&oe=67D6A5A2'),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${user.name} " ,
                                    style: Styles.textStyle700.copyWith(fontSize: 16.sp),
                                  ),
                                  Icon(Icons.edit_outlined, color: CupertinoColors.activeGreen, size: 15.sp),
                                ],
                              ),
                              Text(
                                user.email ,
                                style: Styles.textStyle700.copyWith(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade700, thickness: 1, height: 20),
              SizedBox(height: 6.h),
              ListView.builder(
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _accountItems.length,
                itemBuilder: (context, index) {
                  return CustomAccountProduct(
                    icon: _accountItems[index]['icon'] as IconData,
                    title: _accountItems[index]['title'] as String,
                    screen: _accountItems[index]["widget"],
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _accountItems = [
  {'icon': CupertinoIcons.settings_solid, 'title': "Settings", 'widget':SettingsView(title: " Settings")},
  {'icon': CupertinoIcons.location, 'title': "Delivery Address", 'widget':DeliveryAddressView(title: "Delivery Address",)},
  {'icon': CupertinoIcons.creditcard, 'title': "Payment Methods", 'widget':PaymentMethodsView(title: "Payment Methods",)},
  {'icon': CupertinoIcons.tickets, 'title': "Promo Code", 'widget':PromoCodeView(title: "Promo Code",)},
  {'icon': CupertinoIcons.bell, 'title': "Notification", 'widget':NotificationView(title: "Notification",)},
  {'icon': CupertinoIcons.question_circle, 'title': "Help", 'widget':HelpView(title: "Help",)},
  {'icon': CupertinoIcons.exclamationmark_octagon, 'title': "About", 'widget':AboutView(title: "About",)},
];

class CustomAccountProduct extends StatelessWidget {
  const CustomAccountProduct({
    super.key, required this.icon, required this.title, required this.screen,
  });
  final IconData icon;
  final String title;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorMethods.push(context: context, nextPage: screen),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 25.sp),
              SizedBox(width: 16.w),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Styles.textStyle700.copyWith(fontSize: 14.sp),
                    ),
                    Icon(Icons.navigate_next_sharp, color: Colors.black, size: 18.sp),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey.shade700, thickness: 1, height: 28.h),
        ],
      ),
    );
  }
}