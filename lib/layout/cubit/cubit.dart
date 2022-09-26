import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/Home_model.dart';
import 'package:shop/models/change_favorites_model.dart';
import 'package:shop/models/favorite_model.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/modules/profile/profile_screen.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/local/dio_helper.dart';
import '../../models/categories_model.dart';
import '../../modules/categorise/categorise_screen.dart';
import '../../modules/favorites/favorites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/remote/cash_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());


  static ShopCubit get(context) => BlocProvider.of(context);
  // login
  LoginModel? loginModel;
  void userLogin({
    required String email,
    required String password
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN,
        data: {
          'email': email,
          'password': password
        }
    ).then((value) {
      loginModel = LoginModel.fromJson(value?.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }
  bool isPassword=true;
  void  obscurePassword(){
    isPassword=!isPassword;
    emit(ChangePasswordVisibilityState());
  }
  //register
  void register({
    required String email,
    required String password,
    required String name,
    required String phone,

  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
        }
    ).then((value) {
      loginModel = LoginModel.fromJson(value?.data);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
   //bottom nav bar
  int currentState = 0;
  List<Widget> screens = [Products(), Categorise(), Favorites(), Profile()];
  void changeBottomNavBar(int index) {
    currentState = index;
    emit(ShopChaneBottomNavState());
  }
   //home
  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token:token).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      homeModel!.data!.products.forEach((element) {
        favorite.addAll({
          element.id: element.in_favorites,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
   // categorise
  CategoriseModel? categoriseModel;
  void getCategoriseData() {
    emit(ShopLoadingCategoryDataState());
    DioHelper.getData(url: CATEGORISE).then((value) {
      categoriseModel = CategoriseModel.fromJson(value?.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoryDataState());
    });
  }
   // favorites
  ChangeFavoritesModel? changeFavoritesModel;
  Map<int?, bool?> favorite = {};
  void changeFavoretes(int id) {
    favorite[id] = !favorite[id]!;
    emit(ShopSuccessChangeState());
    DioHelper.postData(
        url: FAVORETES,
        data: {
          'product_id': id
        },
        token:token
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value?.data);
      if (!changeFavoritesModel!.status) {
        favorite[id] = !favorite[id]!;
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
      getFavorites();

    }).catchError((error) {
      favorite[id] = !favorite[id]!;
      print(error.toString());

      emit(ShopErrorChangeFavoritesState());
    });
  }
  FavoriteModel? favoriteModel;
  void getFavorites() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(url: FAVORETES, token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value?.data);
      emit(ShopSuccessFavoritesState());
      print(favoriteModel?.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesState());
    });
  }

   //profile
LoginModel?user;
  void getUserData() {
    emit(ShopLoadingUserState());
    DioHelper.getData(url:PROFILE, token:token).then((value) {
      user = LoginModel.fromJson(value!.data);
      emit(ShopSuccessUserState());
    }).catchError((error) {
      emit(ShopErrorUserState(error));
      print(token);
      print(error.toString());
    });
  }
  void logOut(){
    CashHelper.removeData(key: 'token').then((value){
      changeBottomNavBar(0);
    });
  }
}