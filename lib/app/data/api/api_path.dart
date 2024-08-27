class ApiPath {
  static const String baseUrl = "https://martketnest-b6a16053be02.herokuapp.com";
 // static const String baseUrl = "http://127.0.0.1:3306";
  
  static const login = "v1/login";
  static const register = "v1/create-me";
  static const forgetPassword = "v1/forget-password";
  static const setNewPassword = "v1/set-new-password";
  static const getMe = "v1/get-me";
  static const getCategories = "get-category";
  static const String getSubCategories ="v2/get-sub-category";
  static const String getProducts = "v3/get-product";
  static const confirmViaEmail = "v1/confirm-vai-email";
  static const removeUser = "v1/remove-user";
  static const updateUser = "v1/update";
  static const refreshToken = "v1/generate-new-token";
  static const addToFavorite = "add-to-favorit/products";
  static const removeFavorite = "remove-from-favorit";
}