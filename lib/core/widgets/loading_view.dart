import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/utils/navigator_methods.dart';
import 'package:shop_app/features/home/presentation/manager/shop_cubit.dart';
import 'package:shop_app/features/home/presentation/views/shop_view.dart';
import 'package:shop_app/features/login/presentation/manager/login_cubit.dart';
import 'package:shop_app/features/login/presentation/views/login_view.dart';


class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is AutoLoginFailure){
          NavigatorMethods.pushReplacement(context: context, nextPage: LoginView());
        }
        if(state is AutoLoginSuccess){
          ShopCubit.get(context).fetchHomeModel(token: state.loginData.data.token);
          ShopCubit.get(context).loginModel = state.loginData;
          NavigatorMethods.pushReplacement(context: context, nextPage: ShopView());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: CupertinoColors.systemGreen,),
          ),
        );
      },
    );
  }
}
