import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../manager/shop_cubit.dart';

class ShopViewBodyBottomNavigationBar extends StatelessWidget {
  const ShopViewBodyBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        ShopCubit.get(context).changeCurrentIndexOfBottomNavigatorBar(index);
        if(index == 2 && ShopCubit.get(context).cartData.isEmpty){
          ShopCubit.get(context).fetchCartProducts();
        }
      },
      currentIndex: ShopCubit.get(context).currentIndexOfBottomNavigatorBar,
      items: [
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.manage_search), label: 'Explore'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.opencart), label: 'Cart'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart), label: 'Favorite'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user), label: 'Account'),
      ],
    );
  }
}
