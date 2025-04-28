import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/navigator_methods.dart';
import 'package:shop_app/core/utils/styles.dart';
import 'package:shop_app/core/widgets/custom_text_form_field.dart';
import 'package:shop_app/features/home/presentation/manager/shop_cubit.dart';
import 'package:shop_app/features/login/presentation/views/login_view.dart';
import '../../../../../../core/widgets/custom_button.dart';

class PersonalView extends StatelessWidget {
  final String title;
  const PersonalView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    var data = ShopCubit.get(context).loginModel.data;
    var location = ShopCubit.location.city;
    cubit.userName.text = data.name;
    cubit.phoneNumber.text = data.phone;
    cubit.city.text = location.city;
    cubit.country.text = location.country;
    cubit.postalCode.text = location.postalCode;
    cubit.emailAddress.text = data.email;
    cubit.password.text = data.password;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => NavigatorMethods.pop(context: context),
          icon: Icon(Icons.arrow_back_ios, size: 22.sp),
        ),
        title: Text(
          title,
          style: Styles.textStyle700.copyWith(fontSize: 20.sp),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: TextButton(
              onPressed: () => ShopCubit.get(context).updatePersonalData(),
              child: Text(
                "Save",
                style: Styles.textStyle700.copyWith(
                  fontSize: 16.sp,
                  color: CupertinoColors.activeGreen,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if(state is Logout){
            NavigatorMethods.pushReplacement(context: context, nextPage: LoginView());
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80.sp,
                        backgroundColor:
                            Colors
                                .grey
                                .shade200, // Add a background color for fallback
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: data.image,
                            fit:
                                BoxFit
                                    .cover, // Use cover to ensure it fills the circle
                            placeholder:
                                (context, url) =>
                                    CircularProgressIndicator(), // Add a loading indicator
                            errorWidget:
                                (context, error, stackTrace) => Image.network(
                                  "https://scontent.fcai19-7.fna.fbcdn.net/v/t39.30808-6/473089256_1795702557841991_2045160077905892668_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeHDS1H7r9JqDf8Y3reCHnMp3HUs7sE__SbcdSzuwT_9JsM0775MfBnAFJNYwB_nleZRPoWgQ_vTE5WH6C9ZAEQE&_nc_ohc=E8sNgEP_pMgQ7kNvgHyvmYr&_nc_oc=Adhw80Fc9GTWpOLWS5tHCVup4HvxuCeirGC00pf7sjQ8U30k3fdhWawuVcNO78seWfM&_nc_zt=23&_nc_ht=scontent.fcai19-7.fna&_nc_gid=APLJSZJZddXEJjhl5yudEG7&oh=00_AYGywgzwA9_hPZmo4boPTma2M-82_cYCWgA1XtWX0i_gEg&oe=67D6A5A2",
                                  fit: BoxFit.cover,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  PersonalItem(
                    title: "User Name",
                    controller: cubit.userName,
                    keyboardType: TextInputType.text,
                  ),
                  PersonalItem(
                    title: "Phone Number",
                    controller: cubit.phoneNumber,
                    keyboardType: TextInputType.text,
                  ),
                  PersonalItem(
                    title: "City",
                    controller: cubit.city,
                    keyboardType: TextInputType.text,
                  ),
                  PersonalItem(
                    title: "Country",
                    controller: cubit.country,
                    keyboardType: TextInputType.text,
                  ),
                  PersonalItem(
                    title: "Postal Code",
                    controller: cubit.postalCode,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 35.h),
                  CustomButton(
                    width: double.infinity,
                    borderRadius: 30,
                    onPressed: () {
                      cubit.logout(); // Implement logout logic
                    },
                    text: 'Logout',
                    isBorderSameColor: false,
                    isDefault: false,
                    style: Styles.textStyle700.copyWith(fontSize: 16.sp,color: CupertinoColors.activeGreen),
                    backGroundColor: Colors.transparent,
                    elevation: 0,
                    textColor: CupertinoColors.activeGreen,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PersonalItem extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const PersonalItem({
    super.key,
    required this.title,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Transform.translate(
            offset: Offset(0, 15),
            child: CustomTextFormField(
              height: 32.h,
              startContentPadding: 0,
              borderRadius: 0,
              backgroundColor: Colors.white,
              isEnablePrefixIcon: false,
              isOutlineInputBorder: false,
              isHiddenInputBorder: false,
              controller: controller,
              isLabelText: false,
              title: title,
              enableCompleteStyle: true,
              completeStyle: Styles.textStyle700.copyWith(fontSize: 18.sp),
              keyboardType: TextInputType.text,
            ),
          ),
          Text(
            title,
            style: Styles.textStyle700.copyWith(fontSize: 14.sp,color: Colors.grey),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class PasswordPersonalItem extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool showPassword;
  final void Function()? suffixIconOnPressed;
  const PasswordPersonalItem({
    super.key,
    required this.title,
    required this.controller,
    required this.showPassword,
    this.suffixIconOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Transform.translate(
            offset: Offset(0, 5.5.h),
            child: CustomTextFormField(
              width: 32.h,
              startContentPadding: 0,
              borderRadius: 0,
              backgroundColor: Colors.white,
              isEnablePrefixIcon: false,
              isOutlineInputBorder: false,
              isHiddenInputBorder: false,
              controller: controller,
              isLabelText: false,
              title: title,
              enableCompleteStyle: true,
              completeStyle: Styles.textStyle700.copyWith(fontSize: 18.sp),
              isEnableSuffixIcon: true,
              suffixIcon:
              showPassword ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
              isObscureText: !showPassword,
              suffixIconOnPressed: suffixIconOnPressed,
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          Text(
            title,
            style: Styles.textStyle700.copyWith(fontSize: 14.sp,color: Colors.grey),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
