import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/shop_cubit.dart';
import 'widgets/homeViewBodyWidgets/home_view_body.dart';


class HomeView extends StatelessWidget {

  const HomeView(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
            return HomeViewBody(homeModel: cubit.homeData, categories: cubit.categories);
        }
    );
  }
}
