import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/features/home/presentation/views/widgets/AccountWidgets/personal_view.dart';
import '../../../../../../core/utils/navigator_methods.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../manager/shop_cubit.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    var data = ShopCubit.get(context).loginModel.data;
    cubit.userName.text = data.name;
    cubit.phoneNumber.text = data.phone;
    cubit.emailAddress.text = data.email;
    cubit.password.text = data.password;
    var controller = PageController();
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows content to go behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => NavigatorMethods.pop(context: context),
          icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.white),
        ),
        title: Text(
          title,
          style: Styles.textStyle700.copyWith(
            fontSize: 22.sp,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/SettingsBG.webp',
                  fit: BoxFit.fitWidth,
                ),
              ),
              PersonalInfoView()
            ],
          );
        },
      ),
    );
  }
}

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({super.key});


  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              title: "Email Address",
              controller: cubit.emailAddress,
              keyboardType: TextInputType.text,
            ),
            PasswordPersonalItem(
              title: "Password",
              controller: cubit.password,
              showPassword: cubit.showPassword,
              suffixIconOnPressed: cubit.showPasswordFunc,
            ),
            SizedBox(height: 30.h),
            CustomButton(
              width: double.infinity,
              borderRadius: 30,
              onPressed: () {
                cubit.logout(); // Implement logout logic
              },
              text: 'Logout',
              isBorderSameColor: false,
              isDefault: false,
              style: Styles.textStyle700.copyWith(
                fontSize: 16.sp,
                color: CupertinoColors.activeGreen,
              ),
              backGroundColor: Colors.transparent,
              elevation: 0,
              textColor: CupertinoColors.activeGreen,
            ),
          ],
        ),
      ),
    );
  }
}
