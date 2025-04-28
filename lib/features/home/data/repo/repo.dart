import 'package:dartz/dartz.dart';
import 'package:shop_app/features/home/data/models/cart_model.dart';
import 'package:shop_app/features/home/data/models/search_model.dart';
import 'package:shop_app/features/login/data/models/login_model.dart';

import '../../../../core/errors/failure.dart';
import '../models/category_model.dart';
import '../models/favourite_model.dart';
import '../models/home_model.dart';
import '../models/product_model.dart';



abstract class Repo {
  Future<Either<Failure, HomeModel>> fetchHome({required String lang,required String token});
  Future<Either<Failure, List<CategoryModel>>> fetchCategories({required String lang,required String token});
  Future<Either<Failure, FavouriteModel>> fetchFavourites({required String lang,required String token});
  Future<Either<Failure, List<ProductModel>>> fetchCategoryProducts({required String lang,required String token , required int id});
  Future<Either<Failure, FavouriteModel>> changeFavouriteStatus({required String lang , required int id,required String token});
  Future<Either<Failure, CartModel>> fetchCartProducts({required String lang,required String token});
  Future<Either<Failure, CartModel>> addCartProduct({required String lang , required int id,required String token});
  Future<Either<Failure, CartModel>> deleteCartProduct({required String lang , required int id,required String token });
  Future<Either<Failure, CartModel>> updateCartProduct({required String lang , required int id ,required int quantity,required String token});
  Future<Either<Failure, SearchModel>> searchProduct({required String lang,required String token ,required String text });
  Future<Either<Failure, LoginModel>> updatePersonalData({required String lang,required String token ,required LoginModel login });
// Future<Either<Failure, CartModel>> updateCartProduct({required String lang , required int id ,required int quantity,required String token});

}