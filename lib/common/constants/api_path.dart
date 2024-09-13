import 'package:flutter/foundation.dart';

class ApiPath {
  // static const String baseUrl = "https://martketnest-b6a16053be02.herokuapp.com";
 // static const String baseUrl = "http://127.0.0.1:3306";
  
  static const String login = "v1/login";
  static const String register = "v1/create-me";
  static const String forgetPassword = "v1/forget-password";
  static const String setNewPassword = "v1/set-new-password";
  static const String getMe = "v1/get-me";
  static const String getCategories = "get-category";
  static const String getSubCategories ="v2/get-sub-category";
  static const String getProducts = "v3/get-product";
  static const String getProductByLength = "v3/order-by-list-product";
  static const String addToCart = "/api/store-card-product";
  static const String getCarts = "api/get-all-card";
  static const String confirmViaEmail = "v1/confirm-vai-email";
  static const String removeUser = "v1/remove-user";
  static const String updateUser = "v1/update";
  static const String refreshToken = "v1/generate-new-token";
  static const String addToFavorite = "add-to-favorite/products";
  static const String removeFavorite = "remove-from-favorite";


  static String baseUrl(){
    if(kDebugMode){
      return "http://10.0.2.2:3306";
    }else{
      return "https://martketnest-b6a16053be02.herokuapp.com";
    }
  }
}