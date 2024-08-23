class ApiPath {
  static const String baseUrl = "https://marketnest-007-6005572ffa50.herokuapp.com";
  
  static const login = "v1/login";
  static const register = "v1/create-me";
  static const forgetPassword = "v1/forget-password";
  static const setNewPassword = "v1/set-new-password";
  static const getMe = "v1/users-get-one";
  static const getCategories = "get-category";
  static const confirmViaEmail = "v1/confirm-vai-email";
  static const removeUser = "v1/remove-user/"; ///v1/remove-user/:id
  static const updateUser = "v1/update";
  static const refreshToken = "v1/generate-new-token";
  static const addToFavorite = "add-to-favorit/products";
  static const removeFavorite = "remove-from-favorit";
}