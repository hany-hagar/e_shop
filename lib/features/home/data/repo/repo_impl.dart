import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/features/home/data/models/cart_model.dart';
import 'package:shop_app/features/home/data/models/search_model.dart';
import 'package:shop_app/features/login/data/models/login_model.dart';
import '../../../../const/api_end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/api_services.dart';
import '../models/category_model.dart';
import '../models/favourite_model.dart';
import '../models/home_model.dart';
import '../models/product_model.dart';
import 'repo.dart';

class RepoImpl extends Repo{

  // ---------------- Get ----------------
  @override
  Future<Either<Failure, HomeModel>> fetchHome({required String lang,required String token}) async {
    try {
      final response = await ApiServices().get(url: homeEndPoint,lang: lang,token: token );
      HomeModel homeModel = HomeModel.fromJson(response?.data);
      return Right(homeModel);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories({required String lang,required String token}) async {
    List<CategoryModel> categories = [];
    try {
      final response = await ApiServices().get(url: categoriesEndPoint,lang: lang,token: token);
      for (var item in response?.data["data"]['data']) {
        try {
          item['name'] = item['name'][0].toUpperCase() + item['name'].substring(1);
          categories.add(CategoryModel.fromJson(item));
        } catch (e) {
          // Handle the error if needed
          categories.add(CategoryModel.fromJson(item));
        }
      }
      return Right(categories);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchCategoryProducts({required String lang,required String token, required int id}) async {
    try {
      final response = await ApiServices().get(url: "$categoriesEndPoint/$id",lang: "en",token: token );
      List<ProductModel> productModel = [];
      productModel.clear();
      for (var item in response?.data["data"]['data']) {
        try {
          productModel.add(ProductModel.fromJson(item));
        } catch (e) {
          // Handle the error if needed
          productModel.add(ProductModel.fromJson(item));
        }
      }
      return Right(productModel);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }

  @override
  Future<Either<Failure, FavouriteModel>> fetchFavourites({required String lang,required String token}) async {
    try{
      final response = await ApiServices().get(url: favoritesEndPoint,lang: lang,token: token );
      log("message : ${response?.data['status']}");
      FavouriteModel favourites = FavouriteModel.fromJson(response?.data);
      return Right(favourites);
    }catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> fetchCartProducts({required String lang, required String token}) async {
    try {
      final response = await ApiServices().get(url: cartEndPoint,lang: lang,token: token );
      CartModel products = CartModel.fromJson(response?.data);
      return Right(products);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }


  // ---------------- Post ----------------
  @override
  Future<Either<Failure, FavouriteModel>> changeFavouriteStatus({required String lang , required int id,required String token}) async {
    try {
      final response =
      await ApiServices().post(url: favoritesEndPoint,lang: lang,token: token, data: {
      'product_id':id
      });
      FavouriteModel favouriteModel = FavouriteModel.fromJson(response?.data);
      return Right(favouriteModel);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }

  @override
  Future<Either<Failure, CartModel>> addCartProduct({required String lang , required int id, required String token}) async {
    try {
      final response =
      await ApiServices().post(url: cartEndPoint,lang: lang,token: token, data: {
        'product_id':id
      });
      CartModel product = CartModel.addFromJson(response?.data);
      return Right(product);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }


  // ---------------- Put ----------------
  @override
  Future<Either<Failure, CartModel>> updateCartProduct({required String lang, required int? id , required int quantity ,required String token}) async {
    try {
      final response = await ApiServices().put(url: "$cartEndPoint/$id",lang: lang,token: token, data: {
        'quantity':quantity
      });
      CartModel product = CartModel.updateFromJson(response?.data);
      return Right(product);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginModel>> updatePersonalData({required String lang, required String token, required LoginModel login}) async {
    try {
      final response = await ApiServices().put(url: updateProfileEndPoint,lang: lang,token: token, data: {
      "name": login.data.name.toString(),
      "phone": login.data.phone.toString(),
      "email": login.data.email.toString(),
      "image": "https://images.app.goo.gl/sKtjR2KtmajKJijC6",
      "password": login.data.password.toString()
      });
      log("response message : ${response?.data['message'].toString()}");
      LoginModel data = LoginModel.fromJson(response?.data, login.data.password);

      return Right(data);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }


  // ---------------- Del ----------------
  @override
  Future<Either<Failure, CartModel>> deleteCartProduct({required String lang, required int id,required String token}) async {
    try {
      final response = await ApiServices().del(url: "$cartEndPoint/$id",lang: lang,token: token, );
      CartModel product = CartModel.fromJson(response?.data);
      return Right(product);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }

  @override
  Future<Either<Failure, SearchModel>> searchProduct({required String lang,required String token ,required String text }) async {
    try {
      final response =
          await ApiServices().post(url: searchEndPoint,lang: lang,token: token, data: {
        'text':text
      });
      log("products : ${response?.data.toString()}");
      SearchModel model = SearchModel.fromJson(response?.data);
      // Li product = CartModel.addFromJson(response?.data);
      return Right(model);
    } catch (onError) {
      if (onError is DioException) {
        return Left(ServerFailure.fromDioError(onError));
      }
      return Left(ServerFailure(onError.toString()));
    }
  }


}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}