import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/shop_cubit.dart';
import 'widgets/ExploreWidgets/explore_view_body.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        return ExploreViewBody(categories: ShopCubit.get(context).categories,);
      },
    );
  }
}
