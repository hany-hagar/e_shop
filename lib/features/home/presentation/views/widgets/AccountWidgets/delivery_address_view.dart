import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/features/home/presentation/views/widgets/AccountWidgets/personal_view.dart';

import '../../../../../../core/utils/navigator_methods.dart';
import '../../../manager/shop_cubit.dart';

class DeliveryAddressView extends StatelessWidget {
  const DeliveryAddressView({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    var data = ShopCubit.get(context).loginModel.data;
    var location = ShopCubit.location.city;
    cubit.city.text = location.city;
    cubit.street.text = location.street;
    cubit.country.text = location.country;
    cubit.postalCode.text = location.postalCode;
    cubit.states.text = location.state;

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows content to go behind the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => NavigatorMethods.pop(context: context),
          icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.black),
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
                  'assets/images/delivery_address_bg.png',
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
              title: "Street",
              controller: cubit.street,
              keyboardType: TextInputType.text,
            ),
            PersonalItem(
              title: "State",
              controller: cubit.states,
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

          ],
        ),
      ),
    );
  }
}
