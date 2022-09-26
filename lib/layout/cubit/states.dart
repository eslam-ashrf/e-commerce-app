import 'package:shop/models/change_favorites_model.dart';
import 'package:shop/models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
//home states
class ShopChaneBottomNavState extends ShopStates{}
      //home
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
      //category
class ShopLoadingCategoryDataState extends ShopStates{}
class ShopSuccessCategoryDataState extends ShopStates{}
class ShopErrorCategoryDataState extends ShopStates{}
      // favorites
class ShopSuccessChangeState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates{}
class ShopSuccessFavoritesState extends ShopStates{}
class ShopErrorFavoritesState extends ShopStates{}
class ShopLoadingFavoritesState extends ShopStates{}
      //profile
class ShopSuccessUserState extends ShopStates{}
class ShopErrorUserState extends ShopStates{
  final Error error;

  ShopErrorUserState(this.error);
}
class ShopLoadingUserState extends ShopStates{}
// login states
class LoginLoadingState extends ShopStates{}
class LoginSuccessState extends ShopStates{
  final  LoginModel? loginModel;

  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends ShopStates{
  final String error;

  LoginErrorState(this.error);
}
class ChangePasswordVisibilityState extends ShopStates{}
// register states
class RegisterLoadingState extends ShopStates{}
class RegisterSuccessState extends ShopStates{
  final  LoginModel? loginModel;

  RegisterSuccessState(this.loginModel);
}
class RegisterErrorState extends ShopStates{
  final String error;

  RegisterErrorState(this.error);

}

