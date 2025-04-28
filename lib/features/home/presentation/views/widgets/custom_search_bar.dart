import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/core/utils/styles.dart';
import 'package:shop_app/features/home/presentation/manager/shop_cubit.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class CustomSearchBar extends StatelessWidget {
  final  Function()? onTap;
  final Function(String?)? onChanged;
  const CustomSearchBar({
    super.key, this.onTap, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey(),
      child: CustomTextFormField(
        onTap: onTap,
        onChanged: onChanged,
        height: 35.h,
        borderRadius: 12,
        borderColor: Colors.blueGrey,
        backgroundColor:Theme.of(context).primaryColorLight,
        prefixIcon: FontAwesomeIcons.magnifyingGlass,
        controller: ShopCubit.get(context).search,
        title: 'What are you looking for',
        enableCompleteStyle: true,
        completeStyle: Styles.textStyle700.copyWith(color: Theme.of(context).primaryColor),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
