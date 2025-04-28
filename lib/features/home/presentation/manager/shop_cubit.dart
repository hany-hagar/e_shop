import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/styles.dart';
import 'package:shop_app/features/home/data/models/cart_model.dart';
import 'package:shop_app/features/home/data/models/search_model.dart';
import 'package:shop_app/features/login/data/models/data_model.dart';
import '../../../../core/utils/hive_services.dart';
import '../../../login/data/models/login_model.dart';
import '../../../splash/data/models/location_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/favourite_model.dart';
import '../../data/models/home_model.dart';
import '../../data/models/product_model.dart';
import '../../data/repo/repo_impl.dart';
import '../views/account_view.dart';
import '../views/cart_view.dart';
import '../views/explore_view.dart';
import '../views/favourite_view.dart';
import '../views/home_view.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of<ShopCubit>(context);

  int currentIndexOfBottomNavigatorBar = 0;
  void changeCurrentIndexOfBottomNavigatorBar(int index) {
    currentIndexOfBottomNavigatorBar = index;
    emit(ChangeBottomNavigatorBar());
  }

  static LocationModel location = LocationModel.stander();
  late LoginModel loginModel;
  late HomeModel homeData;
  late FavouriteModel favouritesModel;
  List<CartModel> cartData = [];
  List<CategoryModel> categories = [];
  Map<String, List<ProductModel>> categoriesProducts = {};
  List<ProductModel> favouritesProducts = [];
  List<SearchModel> searchProducts = [];
  List<Widget> kListOfShopView = [
    HomeView(),
    ExploreView(),
    CartView(),
    FavouriteView(),
    AccountView(),
  ];
  var search = TextEditingController();
  bool searchStart = false;
  Future<void> fetchHomeModel({required String token}) async {
    emit(FetchHomeDataLoading());
    var data = await RepoImpl().fetchHome(lang: 'en', token: token);
    data.fold(
      (l) {
        emit(FetchHomeDataFailure(onError: l.errMessage));
      },
      (r) {
        for (var product in r.data.products) {
          if (product.inFavorites) {
            favouritesProducts.add(product);
          }
        }
        emit(FetchHomeDataSuccess(model: r));
        homeData = r;
        fetchCategories();
      },
    );
  }

  Future<void> fetchCategories() async {
    emit(FetchCategoriesDataLoading());
    var data = await RepoImpl().fetchCategories(
      lang: 'en',
      token: loginModel.data.token,
    );
    data.fold(
      (l) {
        emit(FetchCategoriesDataFailure(onError: l.errMessage));
      },
      (r) {
        categories = r;
        Map<String, List<ProductModel>> products = {};
        r.map((element) => products[element.id.toString()] = []);
        categoriesProducts.addAll(products);
        emit(FetchCategoriesDataSuccess(model: r));
      },
    );
  }

  Future<void> autoFetchCategoryProducts({required int id}) async {
    emit(FetchCategoryProductsLoading());
    var data = await RepoImpl().fetchCategoryProducts(
      lang: 'en',
      token: loginModel.data.token,
      id: id,
    );
    data.fold(
      (l) {
        emit(FetchCategoryProductsFailure(onError: l.errMessage));
      },
      (r) {
        emit(FetchCategoryProductsSuccess(model: r));
        List<ProductModel> products = [];

        for (var element in r) {
          for (var toElement in homeData.data.products) {
            if (element.id == toElement.id) {
              products.add(toElement);
              break; // Exit inner loop once a match is found
            }
          }
        }
        categoriesProducts[id.toString()] = products;
      },
    );
  }

  Future<void> fetchCategoryProducts({required int id}) async {
    emit(FetchCategoryProductsLoading());
    var data = await RepoImpl().fetchCategoryProducts(
      lang: 'en',
      token: loginModel.data.token,
      id: id,
    );
    data.fold(
      (l) {
        emit(FetchCategoryProductsFailure(onError: l.errMessage));
      },
      (r) {
        emit(FetchCategoryProductsSuccess(model: r));
        List<ProductModel> products = [];

        for (var element in r) {
          for (var toElement in homeData.data.products) {
            if (element.id == toElement.id) {
              products.add(toElement);
              break; // Exit inner loop once a match is found
            }
          }
        }
        categoriesProducts[id.toString()] = products;
      },
    );
  }

  IconData setFavouriteIcon(ProductModel model) {
    return favouritesProducts.contains(model)
        ? Icons.favorite
        : Icons.favorite_border;
  }

  Future<void> favouriteItemFunc({required int id}) async {
    int index = 0;
    for (index; index <= homeData.data.products.length; index++) {
      if (id == homeData.data.products[index].id) {
        homeData.data.products[index].inFavorites =
            !homeData.data.products[index].inFavorites;
        break;
      }
    }
    if (favouritesProducts.contains(homeData.data.products[index])) {
      favouritesProducts.remove(homeData.data.products[index]);
    } else {
      favouritesProducts.add(homeData.data.products[index]);
    }
    emit(SetFavouriteIcon());
    var data = await RepoImpl().changeFavouriteStatus(
      lang: 'en',
      id: homeData.data.products[index].id,
      token: loginModel.data.token,
    );
    data.fold(
      (l) {
        if (favouritesProducts.contains(homeData.data.products[index])) {
          favouritesProducts.remove(homeData.data.products[index]);
        } else {
          favouritesProducts.add(homeData.data.products[index]);
        }
        homeData.data.products[index].inFavorites =
            !homeData.data.products[index].inFavorites;
        emit(SetFavouriteIconFailure(onError: l.errMessage));
        log("message f : ${l.errMessage}");
      },
      (r) {
        if (r.status) {
          emit(SetFavouriteIcon());
        } else {
          homeData.data.products[index].inFavorites =
              !homeData.data.products[index].inFavorites;
          if (favouritesProducts.contains(homeData.data.products[index])) {
            favouritesProducts.remove(homeData.data.products[index]);
          } else {
            favouritesProducts.add(homeData.data.products[index]);
          }
        }
      },
    );
  }

  Future<void> fetchCartProducts() async {
    cartData.clear();
    emit(FetchCartDataLoading());

    var data = await RepoImpl().fetchCartProducts(
      lang: 'en',
      token: loginModel.data.token,
    );

    data.fold(
      (l) {
        emit(FetchCartDataFailure(onError: l.errMessage));
        log("message : ${l.errMessage}");
      },
      (r) {
        if (r.status) {
          log("Products : ${r.data?.products?.length}");
          List<ProductModel> newProducts = [];
          for (var toElement in r.data?.products ?? []) {
            for (var element in homeData.data.products) {
              if (toElement.id == element.id) {
                element.dataId = toElement.dataId;
                element.quantity = toElement.quantity;
                newProducts.add(element);
                break;
              }
            }
          }
          if (cartData.isNotEmpty) {
            cartData.first.data!.products!.addAll(newProducts);
          } else {
            var model = CartModel(
              status: true,
              message: "message",
              data: Data(total: 0, subTotal: 0, products: newProducts),
            );
            cartData.add(model);
          }
        }

        emit(FetchCartDataSuccess(model: r));
      },
    );
  }

  Future<void> cartItemStatus({
    required ProductModel product,
    required BuildContext context,
  }) async
  {
    int homeIndex = 0;
    int cartIndex = 0;

    // Fix: Prevent out-of-bounds exception in loop
    homeIndex = homeData.data.products.indexOf(product);
    if (product.inCart) {
      if (cartData.isEmpty) {
        fetchCartProducts().then(
          (value) => updateCartProduct(
            cartIndex: cartIndex,
            index: homeIndex,
            newQuantity:
                (cartData.first.data!.products![cartIndex].quantity! + 1),
          ),
        );
      } else {
        if (cartData.first.data?.products!.contains(product) ?? true) {
          fetchCartProducts().then(
            (value) => updateCartProduct(
              cartIndex: cartIndex,
              index: homeIndex,
              newQuantity:
                  (cartData.first.data!.products![cartIndex].quantity! + 1),
            ),
          );
        }
      }
    } else {
      if (cartData.isEmpty) {
        addCartProduct(index: homeIndex, context: context);
      } else {
        if (cartData.first.data!.products!.contains(
          homeData.data.products[homeIndex],
        )) {
          cartIndex = cartData.first.data!.products!.indexOf(
            homeData.data.products[homeIndex],
          );
          updateCartProduct(
            cartIndex: cartIndex,
            index: homeIndex,
            newQuantity:
                (cartData.first.data!.products![cartIndex].quantity! + 1),
          );
        } else {
          addCartProduct(index: homeIndex, context: context);
        }
      }
    }
  }

  Future<void> addCartProduct({
    required int index,
    required BuildContext context,
  }) async
  {
    homeData.data.products[index].inCart =
        !homeData.data.products[index].inCart;
    if (cartData.isEmpty) {
      var model = CartModel(
        status: true,
        message: "message",
        data: Data(
          total: 0,
          subTotal: 0,
          products: [homeData.data.products[index]],
        ),
      );
      cartData.add(model);
    } else {
      cartData.first.data!.products?.add(homeData.data.products[index]);
    }

    var data = await RepoImpl().addCartProduct(
      lang: 'en',
      id: homeData.data.products[index].id,
      token: loginModel.data.token,
    );
    data.fold(
      (l) {
        cartData.first.data!.products?.remove(homeData.data.products[index]);
        homeData.data.products[index].inCart =
            !homeData.data.products[index].inCart;
        emit(AddCartProductItem());
        log("Error : ${l.errMessage}");
      },
      (r) {
        if (r.status) {
          int cartIndex = cartData.first.data!.products!.indexOf(
            homeData.data.products[index],
          );
          homeData.data.products[index].dataId = r.data!.product?.dataId;
          homeData.data.products[index].quantity = r.data!.product?.quantity;
          homeData.data.products[index].price = r.data!.product!.price;
          cartData.first.data!.products?[cartIndex] =
              homeData.data.products[index];
          emit(AddCartProductItem());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 200),
              content: Text(
                r.message.toString(),
                maxLines: 2,
                style: Styles.textStyle700.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              backgroundColor: CupertinoColors.activeGreen,
            ),
          );
        } else {
          cartData.first.data?.products?.remove(homeData.data.products[index]);
          homeData.data.products[index].inCart =
              !homeData.data.products[index].inCart;
          emit(AddCartProductItem());
        }
      },
    );
  }

  Future<void> updateCartProduct({
    required int index,
    required int cartIndex,
    required int newQuantity,
  }) async
  {
    int? quantity = cartData.first.data!.products![cartIndex].quantity;
    cartData.first.data!.products?[cartIndex].quantity = (newQuantity);
    homeData.data.products[index].quantity = (newQuantity);
    emit(UpdateCartProductItem());
    var data = await RepoImpl().updateCartProduct(
      lang: 'en',
      id: homeData.data.products[index].dataId,
      quantity: newQuantity,
      token: loginModel.data.token,
    );
    data.fold(
      (l) {
        cartData.first.data!.products?[cartIndex].quantity = quantity;
        homeData.data.products[index].quantity = quantity;
        log("Update Error : ${l.errMessage}");
        emit(UpdateCartProductItem());
      },
      (r) {
        if (r.status) {
          log("Quantity : ${r.data?.product?.quantity}");
          homeData.data.products[index].dataId = r.data!.product!.dataId;
          homeData.data.products[index].quantity = r.data!.product!.quantity;
          homeData.data.products[index].price = r.data!.product!.price;
          cartData.first.data!.products?[cartIndex] =
              homeData.data.products[index];
          emit(UpdateCartProductItem());
        } else {
          cartData.first.data!.products?[cartIndex].quantity = quantity;
          homeData.data.products[index].quantity = quantity;
          emit(UpdateCartProductItem());
        }
      },
    );
  }

  Future<void> updateCartProductFunc({
    required ProductModel product,
    required int newQuantity,
  }) async
  {
    if (newQuantity != 0) {
      int index = homeData.data.products.indexOf(product);
      int cartIndex = cartData.first.data!.products!.indexOf(
        homeData.data.products[index],
      );
      updateCartProduct(
        index: index,
        cartIndex: cartIndex,
        newQuantity: newQuantity,
      );
    } else {
      deleteProductItem(product: product);
    }
  }

  Future<void> deleteProductItem({required ProductModel product}) async {
    cartData.first.data?.products?.remove(product);
    int index = homeData.data.products.indexOf(product);
    homeData.data.products[index].inCart = false;
    emit(DeleteCartProductItem());
    var data = await RepoImpl().addCartProduct(
      lang: 'en',
      id: product.id,
      token: loginModel.data.token,
    );
    data.fold(
      (l) {
        cartData.first.data!.products?.add(product);
        homeData.data.products[index].inCart = true;
        log("Error message: ${l.errMessage}");
        emit(DeleteCartProductItem());
      },
      (r) {
        if (r.status) {
          homeData.data.products[index].inCart = false;
          emit(DeleteCartProductItem());
        } else {
          cartData.first.data!.products?.add(product);
          homeData.data.products[index].inCart = true;
          emit(DeleteCartProductItem());
        }
      },
    );
  }

  Future<void> searchProductItem({required String text}) async {
    searchProducts.clear();
    var data = await RepoImpl().searchProduct(
      lang: 'en',
      text: text,
      token: loginModel.data.token,
    );
    data.fold(
      (l) {
        log('Error : ${l.errMessage}');
        emit(SearchProduct());
      },
      (r) {
        if (r.status) {
          List<ProductModel> newProducts = [];
          for (var toElement in r.data?.products ?? []) {
            for (var element in homeData.data.products) {
              if (toElement.id == element.id) {
                newProducts.add(element);
                break;
              }
            }
          }
          final searchData = SearchModel(
            status: r.status,
            data: Dat(
              firstPageUrl: r.data?.firstPageUrl ?? '',
              path: r.data?.path ?? '',
              perPage: r.data?.perPage ?? 0,
              total: r.data?.total ?? 0,
              products: newProducts,
              lastPage: r.data?.lastPage ?? 0,
              lastPageUrl: r.data?.lastPageUrl ?? '',
              from: r.data?.from ?? 0,
              to: r.data?.to ?? 0,
              currentPage: r.data?.currentPage ?? 1,
            ),
          );
          searchProducts.add(searchData);
          emit(SearchProduct());
        } else {
          emit(SearchProduct());
        }
      },
    );
  }

  void searchOnTap() {
    emit(SearchProduct());
  }

  var userName = TextEditingController();
  var phoneNumber = TextEditingController();
  var city = TextEditingController();
  var street = TextEditingController();
  var states = TextEditingController();
  var country = TextEditingController();
  var postalCode = TextEditingController();
  var emailAddress = TextEditingController();
  var password = TextEditingController();
  var showPassword = false;
  Future<void> updatePersonalData() async {
    LoginModel login = LoginModel(
      data: DataModel(
        image: loginModel.data.image,
        phone: phoneNumber.text,
        name: userName.text,
        id: loginModel.data.id,
        credit: loginModel.data.credit,
        email: emailAddress.text,
        points: loginModel.data.points,
        token: loginModel.data.token,
        password: password.text,
      ),
      message: loginModel.message,
      status: loginModel.status,
    );
    emit(UpdatePersonalData());
    var data = await RepoImpl().updatePersonalData(
      lang: 'en',
      token: loginModel.data.token,
      login: login,
    );
    data.fold(
      (l) {
        log("message: ${l.errMessage}");
        emit(UpdateCartProductItem());
      },
      (r) {
        if (r.status) {
          loginModel = login;
          HiveServices().updateHiveLoginData(login).then((onValue) {
            emit(UpdatePersonalData());
          });
        } else {
          emit(UpdatePersonalData());
        }
      },
    );
  }

  void showPasswordFunc() async {
    showPassword = !showPassword;
    emit(ShowPassword());
  }

  Future<void> logout() async {
    await HiveServices()
        .deleteHiveLoginData(loginModel)
        .then((onValue) async {
          await HiveServices().deleteHiveLocation(location);
      if (loginModel.isInBox) {
        await loginModel.delete();
      }
      emit(Logout());
    });
  }

  int settingsBoardingPage = 0;
  void settingsOnBoarding(int value){
    settingsBoardingPage = value;
    emit(SettingsOnBoarding());
  }

  var nightMode = ValueNotifier<bool>(false);
  Color background = Colors.black54;

  void changeMode(){
    nightMode.value = !nightMode.value;
    nightMode.value ? background = Colors.white: Colors.black54;
    emit(UpdateMode());
  }

}
