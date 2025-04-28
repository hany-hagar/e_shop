import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manager/shop_cubit.dart';
import 'shop_view_body_bottom_navigation_bar.dart';

class ShopViewBody extends StatelessWidget {
  const ShopViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ShopCubit.get(context).kListOfShopView[ShopCubit.get(context).currentIndexOfBottomNavigatorBar],
              ),
            ],
          ),
          bottomNavigationBar: ShopViewBodyBottomNavigationBar(),
        );
      },
    );
  }
}



