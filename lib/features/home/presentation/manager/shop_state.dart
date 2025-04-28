part of 'shop_cubit.dart';

sealed class ShopState {}

final class ShopInitial extends ShopState {}


final class ChangeBottomNavigatorBar extends ShopState {}


final class FetchHomeDataLoading extends ShopState {}
final class FetchHomeDataSuccess extends ShopState {
  final HomeModel model;

  FetchHomeDataSuccess({required this.model});
}
final class FetchHomeDataFailure extends ShopState {
  final String onError;

  FetchHomeDataFailure({required this.onError});
}


final class FetchCategoriesDataLoading extends ShopState {}
final class FetchCategoriesDataSuccess extends ShopState {
  final List<CategoryModel> model;

  FetchCategoriesDataSuccess({required this.model});
}
final class FetchCategoriesDataFailure extends ShopState {
  final String onError;

  FetchCategoriesDataFailure({required this.onError});
}


final class FetchFavouritesDataLoading extends ShopState {}
final class FetchFavouritesDataSuccess extends ShopState {
  final FavouriteModel model;

  FetchFavouritesDataSuccess({required this.model});
}
final class FetchFavouritesDataFailure extends ShopState {
  final String onError;

  FetchFavouritesDataFailure({required this.onError});
}


final class SetFavouriteIcon extends ShopState {}
final class SetFavouriteIconSuccess extends ShopState {}
final class SetFavouriteIconFailure extends ShopState {
  final String onError;

  SetFavouriteIconFailure({required this.onError});
}


final class FetchCategoryProductsLoading extends ShopState {}
final class FetchCategoryProductsSuccess extends ShopState {
  final List<ProductModel> model;

  FetchCategoryProductsSuccess({required this.model});
}
final class FetchCategoryProductsFailure extends ShopState {
  final String onError;

  FetchCategoryProductsFailure({required this.onError});
}

final class FetchCartDataLoading extends ShopState {}
final class FetchCartDataSuccess extends ShopState {
  final CartModel model;

  FetchCartDataSuccess({required this.model});
}
final class FetchCartDataFailure extends ShopState {
  final String onError;

  FetchCartDataFailure({required this.onError});
}

final class ChangeCartProductStatus extends ShopState{}

final class AddCartProductItem extends ShopState{}

final class UpdateCartProductItem extends ShopState{}

final class DeleteCartProductItem extends ShopState{}


final class SearchProduct extends ShopState{}

final class UpdatePersonalData extends ShopState{}

final class ShowPassword extends ShopState{}

final class Logout extends ShopState{}

final class SettingsOnBoarding extends ShopState{}

final class UpdateMode extends ShopState{}













