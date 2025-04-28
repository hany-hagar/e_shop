import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/features/home/presentation/views/widgets/ExploreWidgets/categories_body.dart';
import 'package:shop_app/features/home/presentation/views/widgets/ExploreWidgets/search_body.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../data/models/category_model.dart';
import '../../../manager/shop_cubit.dart';

class ExploreViewBody extends StatelessWidget {
  final List<CategoryModel> categories;

  const ExploreViewBody({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Find Products',
                style: Styles.textStyle700.copyWith(fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 14.h),
              Center(
                child: GestureDetector(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.93,
                    height: 40.h,
                    child: CustomTextFormField(
                      controller: cubit.search,
                      isLabelText: false,
                      borderColor: Colors.blueGrey,
                      backgroundColor: Colors.white,
                      isEnablePrefixIcon: true,
                      prefixIcon: FontAwesomeIcons.magnifyingGlass,
                      title: 'What are you looking for',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (p0) async {
                        if (cubit.searchStart == false) {
                          cubit.searchProducts.clear();
                          cubit.searchStart = true;
                          cubit.searchOnTap();
                        }
                        await cubit.searchProductItem(text: p0.toString());
                      },
                      onFieldSubmitted: (p0) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ),
              ),
              cubit.searchStart
                  ? cubit.searchProducts.isEmpty
                  ? SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.89,
                child: Center(
                  child: LinearProgressIndicator(
                    color: CupertinoColors.activeGreen,
                  ),
                ),
              )
                  : Expanded( // Move Expanded outside of Padding
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SearchBody(
                    products: cubit.searchProducts.first.data!.products,
                  ),
                ),
              )
                  : Expanded( // Move Expanded outside of Padding
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CategoriesBody(categories: categories),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}

// cubit.searchStart
// ? cubit.searchProducts.isEmpty
// ? SizedBox(
// width: MediaQuery.sizeOf(context).width * 0.89,
// child: Center(
// child: LinearProgressIndicator(
// color: CupertinoColors.activeGreen,
// ),
// ),
// )
//     : Expanded( // Move Expanded outside of Padding
// child: Padding(
// padding: const EdgeInsets.symmetric(vertical: 16.0),
// child: SearchBody(
// products: cubit.searchProducts.first.data!.products,
// ),
// ),
// )
//     : Expanded( // Move Expanded outside of Padding
// child: Padding(
// padding: const EdgeInsets.all(16),
// child: CategoriesBody(categories: categories),
// ),
// ),